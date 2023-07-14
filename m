Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C9754287
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbjGNS05 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjGNS04 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 14:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295526BB;
        Fri, 14 Jul 2023 11:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A09761D96;
        Fri, 14 Jul 2023 18:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC83C433C7;
        Fri, 14 Jul 2023 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689359214;
        bh=Uqw01r9Q4nZaSGzSWhg/cFs1K2/ha6NQPIvt32ce+Kk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MX55XQyE/P6pepwgUDQ/NMw+IrIagoENtcz2vTHQOrFVh7sSbxbT6IOUrcvo+3/LV
         CuR9sSTdByUL1ulAhAXa/UiU5xuy8+29hj0rhSutkYXDUzK6Yz+btcLVjxG8iHmoh4
         61RSmgVQw6cYBpXu2Rb64eTbz6FC98nJTgvM2iOo=
Date:   Fri, 14 Jul 2023 11:26:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Message-Id: <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
In-Reply-To: <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
        <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
        <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
        <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
        <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
        <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 14 Jul 2023 11:19:11 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> On 7/14/23 11:09, Mark Brown wrote:
> > On Fri, Jul 14, 2023 at 11:48:51AM -0600, Shuah Khan wrote:
> >> On 7/13/23 14:16, John Hubbard wrote:
> > 
> >>> Actually, I was hoping that my two fixes [1], [2] could be used, instead
> >>> of reverting the feature.
> > 
> >> Mark! Are you good with taking these two - do these fix the
> >> problems you are seeing?
> > 
> > I reviewed the one that's relevant to me already, the arm64 one, I'd not
> > seen or tested the RISC-V one but that looks fine too.  I'm pretty sure
> 
> That riscv patch already has a Tested-by from Alexandre Ghiti:
> 
> https://lore.kernel.org/f903634d-851f-af64-8d9a-6b13d813587c@ghiti.fr
> 
> 
> > Andrew queued it already though ICBW.  Either way it'd be good to get
> > this into -rc2, this is seriously disrupting arm64 CI and I'm guessing
> > the RISC-V CI too.
> 

I just dropped
selftests-arm64-fix-build-failure-during-the-emit_tests-step.patch and
selftests-fix-arm64-test-installation.patch, as Shuah is merging them.

This is all rather confusing.  Perhaps a full resend of everything will
help.  I'll assume that Shuah will be handling them.
