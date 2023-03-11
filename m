Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013936B5BFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 13:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCKMx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Mar 2023 07:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCKMxr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Mar 2023 07:53:47 -0500
Received: from mail.schwarzvogel.de (unknown [IPv6:2a01:4f8:252:1806::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E56252A5
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Mar 2023 04:53:36 -0800 (PST)
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.96)
        (envelope-from <klausman@schwarzvogel.de>)
        id 1payj8-000hMu-2y
        for linux-kselftest@vger.kernel.org;
        Sat, 11 Mar 2023 13:53:34 +0100
Date:   Sat, 11 Mar 2023 13:53:34 +0100
From:   Tobias Klausmann <klausman@schwarzvogel.de>
To:     linux-kselftest@vger.kernel.org
Subject: Re: BUG in dhrystone selftest on v6.3-rc1
Message-ID: <2750b3d6-a09e-48ef-a041-57fa43ae4d15@skade.local>
References: <4aeec948-f1b8-4d2a-b096-b2d6104946ba@skade.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aeec948-f1b8-4d2a-b096-b2d6104946ba@skade.local>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi! 

On Fri, 10 Mar 2023, Tobias Klausmann wrote:
> BUG: using smp_processor_id() in preemptible [00000000] code: bash/1903
> caller is dhry_benchmark+0x39/0x90

Also filed here:

https://bugzilla.kernel.org/show_bug.cgi?id=217179

Best,
Tobias

-- 
panic("%s called.  This Does Not Happen (TM).", __FUNCTION__);
        linux-2.6.6/arch/mips/mm-64/tlb-dbg-r4k.c
