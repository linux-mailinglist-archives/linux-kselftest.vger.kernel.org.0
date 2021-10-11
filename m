Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A5428ABF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhJKKaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 06:30:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3957 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhJKKaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 06:30:10 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSZgK64P2z687Dq;
        Mon, 11 Oct 2021 18:25:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 12:28:09 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 11:28:08 +0100
Date:   Mon, 11 Oct 2021 11:27:50 +0100
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
Subject: Re: [PATCH v1 10/38] arm64/sve: Generalise vector length
 configuration prctl() for SME
Message-ID: <20211011112750.00004066@Huawei.com>
In-Reply-To: <20210930181144.10029-11-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
        <20210930181144.10029-11-broonie@kernel.org>
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

On Thu, 30 Sep 2021 19:11:16 +0100
Mark Brown <broonie@kernel.org> wrote:

> In preparation for adding SME support update the bulk of the implementation
> for the vector length configuration prctl() calls to be independent of
> vector type.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

And let the trivial continue (which is just a reflection of the fact I don't have
enough of a grasp on this to find anything substantial - or there is nothing there
to find :)

...

>  	/*
> -	 * Clamp to the maximum vector length that VL-agnostic SVE code can
> -	 * work with.  A flag may be assigned in the future to allow setting
> -	 * of larger vector lengths without confusing older software.
> +	 * Clamp to the maximum vector length that VL-agnostic code
> +	 * can work with.  A flag may be assigned in the future to
> +	 * allow setting of larger vector lengths without confusing
> +	 * older software.

Why the oddly short wrapping at sub 70 chars?

>  	 */
> -	if (vl > SVE_VL_ARCH_MAX)
> -		vl = SVE_VL_ARCH_MAX;
> +	if (vl > VL_ARCH_MAX)
> +		vl = VL_ARCH_MAX;
