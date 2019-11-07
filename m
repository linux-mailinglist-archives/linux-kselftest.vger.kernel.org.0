Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA76F399E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 21:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfKGUia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 15:38:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46947 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGUia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 15:38:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so3187454otr.13
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 12:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAvLKKV7IQqyzDk29J8CPSyMwILSWd7yaDOdxYjUUcA=;
        b=v7FWg/drbXTupxCwo7n5nLGUGGsZsM4s67/spy2JdOS7XlpDrc2MwzDvV0LGgtaxek
         K/HFYdZPSrcehbndsafkeYnKO8Uwbm1rlQpTSV9WC0W4wupNr0peQQe324xVw5LU6KPK
         /e1a9Nybf3daVwqcTIksamE5jnbb7pcUsgp7wjlC8KtZqXXXjbpKYR2AFYkcDXau5KFj
         A9fQRVKgUfoLirRsquE1x9rEmpjPEXGAuG7A7WMjfa5iAG0yAg0BkfeP3sEIsvXl5EbJ
         RXYelB5Ak5dn6TrrM17T213rXHtMlJqYo3gF8nQVdfvRIQ5T0wakcsrtaK63B66jH5Ox
         qfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAvLKKV7IQqyzDk29J8CPSyMwILSWd7yaDOdxYjUUcA=;
        b=ETpiv4L37Lb708F1v4gtrIL45tjWTO98nHQTyPO60vq2RNOaL19/Oyph3NHs+3d4Wo
         0KGkZgi11s7fJwfSv3fj5ndnz15wJzHG0Rr2s5q7iM1lGaHuDzoG3ZMFHzv1AEoHNCMf
         OSoaUTyzcovO2Ib99iu+ikyLPv+RnPcVKV8G7kOR/Y5Ihb+e9uxWpRAMh58qdOaX6Inp
         GjrAw8EtnSR8c9i+/aV8kiEhFOC+03K97nkpdGPhANDeXvTq7F/5d9qlHGcPBV2EiY0R
         hRX220lo6Qju9fFKbJTyl/pnBSYLkMDLzNCDHnGeoKlrcFGrSemhzBoBMIKZ5MiN+y2k
         ZC/g==
X-Gm-Message-State: APjAAAW3zp6egh3EgLzbsabS3ojfnGEsnRI9OxEiPqMuf12Z4c3AHGrC
        e9eCa6ZZHWgcyyrOVJJxGtDRo8rpBmIR8xAli381Jw==
X-Google-Smtp-Source: APXvYqxomvPfEM5msOKAlLPQPwxPXfUmHGU6ayXO7xpGMhHdRMwxVUABpD3eQCdE5spOOaWDpdUARnv28rdfzJ3HzlE=
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr1114517oto.352.1573159108999;
 Thu, 07 Nov 2019 12:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20191105094029.21213-1-ice_yangxiao@163.com> <0ec9a9e3-96a7-32e1-ffe6-125321a9fc4c@kernel.org>
In-Reply-To: <0ec9a9e3-96a7-32e1-ffe6-125321a9fc4c@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 7 Nov 2019 12:38:17 -0800
Message-ID: <CALAqxLVtOfsvwOYf1zqwB6TrwFt1nkBzU=2opH7fE8YX49Y1Ag@mail.gmail.com>
Subject: Re: [PATCH] dmabuf-heaps/dmabuf-heap.c: Initialize features variable
 to avoid compiler warning
To:     shuah <shuah@kernel.org>
Cc:     Xiao Yang <ice_yangxiao@163.com>, linux-kselftest@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 7, 2019 at 12:30 PM shuah <shuah@kernel.org> wrote:
> On 11/5/19 2:40 AM, Xiao Yang wrote:
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
>
> Missing commit log. Please add one to show the compiler warn you are
> fixing.

Shuah's feedback is good advice for future patches, but I wanted to
clarify that I've dropped the affected code, so there's no reason to
respin this patch.

thanks
-john
