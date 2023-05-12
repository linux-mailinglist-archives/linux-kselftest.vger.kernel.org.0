Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE14701216
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 May 2023 00:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjELWPg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjELWPe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 18:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC1198B;
        Fri, 12 May 2023 15:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E594639DE;
        Fri, 12 May 2023 22:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1050C433D2;
        Fri, 12 May 2023 22:15:18 +0000 (UTC)
Date:   Fri, 12 May 2023 18:15:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.ibm.com>,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, naveen.n.rao@linux.ibm.com
Subject: Re: [PATCH v3 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Message-ID: <20230512181517.607ff03d@rorschach.local.home>
In-Reply-To: <54bec864-5e4f-8432-a331-e4ea5fc2ba31@linuxfoundation.org>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
        <20230428163842.95118-3-akanksha@linux.ibm.com>
        <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
        <54bec864-5e4f-8432-a331-e4ea5fc2ba31@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 8 May 2023 11:36:28 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >   
> 
> Would you like this patch to go through kselftest tree?

Shuah, you can take it through your kselftest tree.

Thanks!

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
