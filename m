Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5236B7A55
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCMOaj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCMOai (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 10:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06B193EF;
        Mon, 13 Mar 2023 07:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB9B61309;
        Mon, 13 Mar 2023 14:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D73C433EF;
        Mon, 13 Mar 2023 14:30:36 +0000 (UTC)
Date:   Mon, 13 Mar 2023 10:30:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     paranlee <p4ranlee@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Update comment and clean up
Message-ID: <20230313103033.7bb461ef@gandalf.local.home>
In-Reply-To: <20230311124151.43691-1-p4ranlee@gmail.com>
References: <20230311124151.43691-1-p4ranlee@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 11 Mar 2023 21:41:53 +0900
paranlee <p4ranlee@gmail.com> wrote:

> Update renamed function comment
> and clean up indent from 4 space to tab.

This isn't C code, it's a shell script where editors do things differently.

I only care that the file is constant in its indenting.

I won't nack this, but I won't ack it nor take it myself.

-- Steve
