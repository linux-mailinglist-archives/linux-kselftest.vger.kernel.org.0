Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED979C394
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 05:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbjILDCv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 23:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbjILDCi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 23:02:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0F91A4BE3;
        Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4ADC3278E;
        Tue, 12 Sep 2023 00:57:01 +0000 (UTC)
Date:   Mon, 11 Sep 2023 20:57:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [FIX PATCH] selftests: tracing: Fix to unmount tracefs for
 recovering environment
Message-ID: <20230911205718.5bc23f8d@gandalf.local.home>
In-Reply-To: <20230912095457.e5b89f84e168ed06072ea3d5@kernel.org>
References: <169425219871.184380.8584599358250186540.stgit@devnote2>
        <20230911130909.6d3054af@gandalf.local.home>
        <20230912095457.e5b89f84e168ed06072ea3d5@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 Sep 2023 09:54:57 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Shouldn't the above be:
> > 
> >      if [ ! -z "${UNMOUNT_DIR}" ]; then
> > 
> > ?  
> 
> I think both are good.
> What about using '-n' explictly?
> 
> [ -n "${UNMOUNT_DIR}" ]

Even better. Heh, I never even knew about that switch :-p

-- Steve
