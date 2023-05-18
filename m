Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A4D70791A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 06:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjERE3z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 00:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjERE3r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 00:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0342D7F;
        Wed, 17 May 2023 21:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE9D64C15;
        Thu, 18 May 2023 04:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0AAC433D2;
        Thu, 18 May 2023 04:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684384185;
        bh=gn5L75pkGhqNPLBtXjay+iXdAWrG4G0ZTKO+AjiN/0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pghwWfIisZn09xJiwdY/i1U2aW+EO7wKhVahdIH2MbsWA6PDjMWdAbBudDjeCuipC
         /49+8/HI/m4C5mxXjQirRI9duOQ7nSZIZgG+ELyH+kvVC2KuXaTZQZ+7VSepRjOZmP
         U0+pIG6QOF7OY+kXofMXL+jjm42TedKm9qqShKVfb9jwPHza+CK0yVVUbIWzXAY/lG
         RgRWdJ06nLfr00L3HezQuCONro9wZSo7rHzdvBFKGiVim4Lz8H62ltbuL6SclJm5LK
         CUPQy7dNysXyzUelWYdStbp12e5bArPh9gzQEuDPmWYdus7458jfDXnJzX7HQNF1WC
         FjjL3TbLu+4KQ==
Date:   Thu, 18 May 2023 13:29:41 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.ibm.com>,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, naveen.n.rao@linux.ibm.com
Subject: Re: [PATCH v3 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Message-Id: <20230518132941.0d2c3a4dde48063514e001d4@kernel.org>
In-Reply-To: <08abb08f-68d9-54d0-cb7a-ba56a73a9856@linuxfoundation.org>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
        <20230428163842.95118-3-akanksha@linux.ibm.com>
        <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
        <54bec864-5e4f-8432-a331-e4ea5fc2ba31@linuxfoundation.org>
        <20230512181517.607ff03d@rorschach.local.home>
        <08abb08f-68d9-54d0-cb7a-ba56a73a9856@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 17 May 2023 10:26:43 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 5/12/23 16:15, Steven Rostedt wrote:
> > On Mon, 8 May 2023 11:36:28 -0600
> > Shuah Khan <skhan@linuxfoundation.org> wrote:
> > 
> >>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>>    
> >>
> >> Would you like this patch to go through kselftest tree?
> > 
> > Shuah, you can take it through your kselftest tree.
> > 
> > Thanks!
> > 
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> 
> Applied to linux-kselftest next for 6.5-rc1

Thank you Shuah!

> 
> thanks,
> -- Shuah
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
