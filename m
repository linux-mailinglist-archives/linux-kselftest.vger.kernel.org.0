Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4293E316093
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhBJIHd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Feb 2021 03:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBJIH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Feb 2021 03:07:27 -0500
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2FC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Feb 2021 00:06:47 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4DbC5d0JN9zvjhQ; Wed, 10 Feb 2021 09:06:44 +0100 (CET)
Date:   Wed, 10 Feb 2021 09:06:44 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, shuah@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, vincenzo.frascino@arm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] selftests/vDSO: fix ABI selftest on riscv
Message-ID: <20210210080644.gc3wyt4fq72u3khz@distanz.ch>
References: <20210204145042.7345-1-tklauser@distanz.ch>
 <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
 <20210205075745.jlf3vsjkp3n3rwss@distanz.ch>
 <5a8923b2-0c5e-ab6c-52fd-f00bc1361a3f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8923b2-0c5e-ab6c-52fd-f00bc1361a3f@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-02-09 at 00:37:24 +0100, Shuah Khan <skhan@linuxfoundation.org> wrote:
> On 2/5/21 12:57 AM, Tobias Klauser wrote:
> > On 2021-02-05 at 08:06:37 +0100, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > On Thu, 04 Feb 2021 06:50:42 PST (-0800), tklauser@distanz.ch wrote:
> > 
> > [...]
> > 
> > > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > > Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > 
> > Thank you!
> > 
> > > Not sure if you want this through the RISC-V tree, so I'm leaving it out for
> > > now and assuming it'll go through a kselftest tree.
> > 
> > Either way is fine for me.
> > 
> 
> Thank you. Applied to linux-kselftest next for 5.12-rc1

Thank you Shuah!
