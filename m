Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8415A310625
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 08:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhBEH6f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 02:58:35 -0500
Received: from sym2.noone.org ([178.63.92.236]:45070 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhBEH6c (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 02:58:32 -0500
X-Greylist: delayed 61620 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2021 02:58:32 EST
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4DX77Z6d1LzvjhV; Fri,  5 Feb 2021 08:57:46 +0100 (CET)
Date:   Fri, 5 Feb 2021 08:57:46 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     shuah@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, vincenzo.frascino@arm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] selftests/vDSO: fix ABI selftest on riscv
Message-ID: <20210205075745.jlf3vsjkp3n3rwss@distanz.ch>
References: <20210204145042.7345-1-tklauser@distanz.ch>
 <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-02-05 at 08:06:37 +0100, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Thu, 04 Feb 2021 06:50:42 PST (-0800), tklauser@distanz.ch wrote:

[...]

> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thank you!

> Not sure if you want this through the RISC-V tree, so I'm leaving it out for
> now and assuming it'll go through a kselftest tree.

Either way is fine for me.
