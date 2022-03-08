Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041394D1717
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 13:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbiCHMTB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 07:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346785AbiCHMS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 07:18:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B6F36B52;
        Tue,  8 Mar 2022 04:18:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCZ9527H4z4xy4;
        Tue,  8 Mar 2022 23:18:01 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        shuah@kernel.org, "Pratik R. Sampat" <psampat@linux.ibm.com>
In-Reply-To: <20220217105321.52941-1-psampat@linux.ibm.com>
References: <20220217105321.52941-1-psampat@linux.ibm.com>
Subject: Re: [PATCH v9 0/2] Interface to represent PAPR firmware attributes
Message-Id: <164674128970.3322453.9483045885684734218.b4-ty@ellerman.id.au>
Date:   Tue, 08 Mar 2022 23:08:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 17 Feb 2022 16:23:19 +0530, Pratik R. Sampat wrote:
> RFC: https://lkml.org/lkml/2021/6/4/791
> PATCH v1: https://lkml.org/lkml/2021/6/16/805
> PATCH v2: https://lkml.org/lkml/2021/7/6/138
> PATCH v3: https://lkml.org/lkml/2021/7/12/2799
> PATCH v4: https://lkml.org/lkml/2021/7/16/532
> PATCH v5: https://lkml.org/lkml/2021/7/19/247
> PATCH v6: https://lkml.org/lkml/2021/7/20/36
> PATCH v7: https://lkml.org/lkml/2021/7/23/26
> PATCH v8: https://lkml.org/lkml/2021/9/28/554
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/pseries: Interface to represent PAPR firmware attributes
      https://git.kernel.org/powerpc/c/3c14b73454cf9f6e2146443fdfbdfb912c0efed3
[2/2] selftest/powerpc: Add PAPR sysfs attributes sniff test
      https://git.kernel.org/powerpc/c/57201d657eb76d735298405d3200a3b1f67197e1

cheers
