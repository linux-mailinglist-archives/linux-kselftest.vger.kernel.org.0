Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2724647919
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 23:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHW6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 17:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLHW5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 17:57:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9EF1D0F7;
        Thu,  8 Dec 2022 14:57:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE87E61E67;
        Thu,  8 Dec 2022 22:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BD9C433D2;
        Thu,  8 Dec 2022 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670540268;
        bh=J62E11sn8qsM+R0hA1OPkrH4gqvUGkhVQ60dIfCwpQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BtgRTKIxalDih7iHzpywEySr9EQib0imytn/gprBsYsNHwPMJxdg2XD+lpDuBWvti
         BbKr2Tk7e9KZJmY9ib0Nm3Wt8o7LlKIwoDJJDx3UcJX7VQ4m6gyQVsx7SK97OYLYxK
         l58gDt3aHfPDxDQZmmpxi5KpR+LOn9dOcQ2yRCTo=
Date:   Thu, 8 Dec 2022 14:57:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kselftest@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Add Dhrystone benchmark test
Message-Id: <20221208145745.a0424a67725f431a28737b6a@linux-foundation.org>
In-Reply-To: <4d07ad990740a5f1e426ce4566fb514f60ec9bdd.1670509558.git.geert+renesas@glider.be>
References: <4d07ad990740a5f1e426ce4566fb514f60ec9bdd.1670509558.git.geert+renesas@glider.be>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  8 Dec 2022 15:31:28 +0100 Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Hence make the classical Dhrystone 2.1 benchmark available as a Linux
> kernel test module, based on[1].

I can take a look at this after the merge window.

I'm not able to figure out the licensing of this. 
https://netlib.org/benchmark/dhry-c appears to be silent on the topic?

