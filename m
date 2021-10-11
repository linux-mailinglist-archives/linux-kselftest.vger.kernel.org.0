Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78DA428CDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhJKMRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 08:17:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3959 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbhJKMRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 08:17:41 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSd3M465Fz686rF;
        Mon, 11 Oct 2021 20:12:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 14:15:39 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 13:15:38 +0100
Date:   Mon, 11 Oct 2021 13:15:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Alan Hayward" <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        "Salil Akerkar" <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 21/38] arm64/sme: Implement SVCR context switching
Message-ID: <20211011131520.00004f0d@Huawei.com>
In-Reply-To: <20210930181144.10029-22-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
        <20210930181144.10029-22-broonie@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.204]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Sep 2021 19:11:27 +0100
Mark Brown <broonie@kernel.org> wrote:

> In SME the use of both streaming SVE mode and ZA are tracked through
> PSTATE.SM and PSTATE.ZA, visible through the system register SVCR.  In
> order to context switch the floating point state for SME we need to
> context switch the contents of this register as part of context
> switching the floating point state.
> 
> Since changing the vector length exits streaming SVE mode and disables
> ZA we also make sure we update SVCR appropraitely when setting vector

appropriately

> length, and similarly ensure that new threads have streaming SVE mode
> and ZA disabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
...
