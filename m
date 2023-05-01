Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59A6F3682
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEATKo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEATKn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 15:10:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD921FC0;
        Mon,  1 May 2023 12:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F5B618AC;
        Mon,  1 May 2023 19:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC40C433D2;
        Mon,  1 May 2023 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682968241;
        bh=7wA5MD8Ul6eRk6o5es1/yKxJrO4V6BCjnRixIYeEAH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7pkR9OU+t1cf869c4V7a2oISoGQAT53bNvhWLJU+6ypkVtMDi06q3P9Uow1MnSkM
         O52pydRtx/rKTnnhHrzaiwXufppnjN04ezUfGxlyA+K/8i8+AaQBENv7SBOTEyFVlz
         U3yoTkb14H4jQ/9UqMvWJ60n4LdIZ+NMRWOZ3S4h0ky6oqKt0kZ71gX2Z9/NQ6te2k
         IYkV5WRuwBbyJLlhFtGYnE4hcuIshLMOJ6/TLyA0uijhZkMs6hQMsd50MwEPQPfyiT
         IsxgZrMislen5Oe6a/wDKyafq/lzH8batbx8LWF8CPqeBycng9Zho5Z87aTNHK8pGc
         cJgSctxNPr4YQ==
From:   SeongJae Park <sj@kernel.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] kunit: tool: undo type subscripts for subprocess.Popen
Date:   Mon,  1 May 2023 19:10:39 +0000
Message-Id: <20230501191039.140496-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501181610.2617032-1-dlatypov@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 1 May 2023 11:16:10 -0700 Daniel Latypov <dlatypov@google.com> wrote:

> Writing `subprocess.Popen[str]` requires python 3.9+.
> kunit.py has an assertion that the python version is 3.7+, so we should
> try to stay backwards compatible.
> 
> This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
> pre-existing `mypy --strict` errors and update run_checks.py"), since
> mypy complains like so
> > kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]
> 
> Note: `mypy --strict --python-version 3.7` does not work.
> 
> We could annotate each file with comments like
>   `# mypy: disable-error-code="type-arg"
> but then we might still get nudged to break back-compat in other files.
> 
> This patch adds a `mypy.ini` file since it seems like the only way to
> disable specific error codes for all our files.
> 
> Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
> but I think being explicit is better, particularly since most kernel
> devs won't be familiar with how mypy works.

Thank you for fast fix!

> 
> Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
> Reported-by: SeongJae Park <sj@kernel.org>
> Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
