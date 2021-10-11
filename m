Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1502428DB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhJKNUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 09:20:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3963 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhJKNUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 09:20:22 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSfRh3S3Lz67YMc;
        Mon, 11 Oct 2021 21:15:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 15:18:20 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 14:18:19 +0100
Date:   Mon, 11 Oct 2021 14:18:01 +0100
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
Subject: Re: [PATCH v1 08/38] arm64/sve: Track vector lengths for tasks in
 an array
Message-ID: <20211011141801.0000224a@Huawei.com>
In-Reply-To: <YWQ4qDmu8Yyiwm5C@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
        <20210930181144.10029-9-broonie@kernel.org>
        <20211011112057.00007b90@Huawei.com>
        <YWQ4qDmu8Yyiwm5C@sirena.org.uk>
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

On Mon, 11 Oct 2021 14:14:16 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Oct 11, 2021 at 11:20:57AM +0100, Jonathan Cameron wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > As for SVE we will track a per task SME vector length for tasks. Convert
> > > the existing storage for the vector length into an array and update
> > > fpsimd_flush_task() to initialise this in a function.  
> 
> > I'm clearly having a trivial comment day.  Given reduction in indenting
> > it would be nice perhaps to reformat comments to take that into account.  
> 
> Again I'll have done this to make it clearer that things are just being
> moved about - as a reviewer I do find things like that very helpful.
> 
> > I'm also unconvinced the trivial wrappers are worthwhile.  (maybe you drop
> > those later?)  
> 
> They do hide what we're doing from the rest of the series which makes
> the whole thing a lot easier to work with, especially if we change what
> data structures we use or there's some debate as to the names of the
> constants.  A bunch of them directly map onto existing trivial wrappers
> too, there's been some stylistic preference for that.
> 
> If people want to remove the wrappers I'd propose leaving them for now
> then adding a patch afterwards which removes them, or at least waiting
> until we've got very firm agreement from Catalin and Will on the data
> structures and constants.
> 

Makes sense.

J
