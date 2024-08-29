Return-Path: <linux-kselftest+bounces-16688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7749648E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D3EFB232C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCB198E75;
	Thu, 29 Aug 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lz1S0X2q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96118D65D
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942771; cv=none; b=r8VLIuejT73oA4Kc9kgkYwqWd63XTdMZW0SNnpydipXsqGwbsG0NercdCfMiTkZCVUnLN7s0GXOS6InTt9rpXSwMhX4kyNGjq54qZrHsXa4IQZV6qWCTMjANS0gkF6THlB0Wk0d/z/Iu66TbiH+nHQyTz2BIDepWt8/0bZuA5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942771; c=relaxed/simple;
	bh=WdScwWSRZMYNWo7qq85UIdpjQhQNKPC+IHDSE2KFxWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNoYRCg1zrS97s4VEdZVPupspuBLq+x9Dgg5V/CncGIllyMMJOMoAeQAEzqv/W3cOEJtdjfebfQp/YXvg9n6Zi1HOLG1OS6ng254VKESfp9w/AssdvvSVq75Q8AflOz1q5ipYLy083Rnsctfe35MLKbD8QM6TUiMmThaV/e09JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lz1S0X2q; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2705061b3fdso84294fac.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724942768; x=1725547568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCN3u5a8S33nBFxuXGEHGtvmcxNmqd72t1VtdnAXjS4=;
        b=Lz1S0X2qIwffRqccXX5IMz4YcVbItXr9Uul19bfo1d0h7gtjBfMQ1HhemHWne/iCQH
         /MjkAUDcfJOP99PRd50Bk+lLSj3zKa6dhLbHOy8lg/KvCsEWVMLDKiqlfoNfSh+N82QU
         nner8vH+d93BkZPu/jpVAPmKR0xUo20y/d9xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942768; x=1725547568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCN3u5a8S33nBFxuXGEHGtvmcxNmqd72t1VtdnAXjS4=;
        b=ct9BovpD5XhEFOaXTd9L6FrF8WEW1gK0ufPSI0blC/a6uQVhIdb1an92dA61t+TuhD
         W0zcCgRDC3kBifb5F0BUaAz14aQ2fvpiHpZVfLt7UgW6L08RW0CHzW5TufQsNTh43pFV
         ai38iw2ZEIE+rxcJJmYru4mQsu4g+TdY2RTjdsAwQHNehdlwGDcnFYKhvpPtaPXk5Taj
         FQw5TwaqUbTLaAGMLn7lA/NnfYAMpNZQtAWwD7VKgtOVMe/WYZS453DbExMoUAAF07o+
         o42uXCnYqkRHlyjbQrzBtA+DNBSf31Rfw60J8PqXmZuqoAeI3qJ1VdxnLWthskkz+ZUh
         WIYg==
X-Gm-Message-State: AOJu0YyiV6xFrrtZfi1eOlHg1UhYj+wYCI6nIwHtO6v4Bz0TtwN7cPbR
	TWfUN3ZG4Z15Kh/mKTxF02LZIgJiHqQpfxywRyDxaKpPcsAnC+EGetzRF1c55TgIYq7ywvP2AcG
	Lprdc3AuLPV5YFSuYYWsqVLM3cDCW6Zo+ifpv
X-Google-Smtp-Source: AGHT+IGSnXMxyJ5pdcjfudl0GOhu+trj+LwVbeI3RMw1yuYwl+wqVmSHr46eWWVKC1gi7bGtjX/ODI6VgTElteFKUbQ=
X-Received: by 2002:a05:6870:702b:b0:254:a7df:721b with SMTP id
 586e51a60fabf-277902c5ce4mr1741754fac.5.1724942768516; Thu, 29 Aug 2024
 07:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
In-Reply-To: <20240828225522.684774-2-jeffxu@chromium.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:45:56 -0700
Message-ID: <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, rientjes@google.com, 
	keescook@chromium.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Andrew

On Wed, Aug 28, 2024 at 3:55=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add more testcases and increase test coverage, e.g. add
> get_vma_size to check VMA size and prot bits.
>

Could you please pull the self-test part of this patch series to mm-unstabl=
e ?
It will help to prevent regression.

The first part ([PATCH v1 1/2] mseal: fix mmap(FIXED) error code) can
be ignored as Liam proposed to fix it differently.

Thanks
-Jeff

-Jeff

> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 826 ++++++++++++++++++++++--
>  1 file changed, 759 insertions(+), 67 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index e7991e5fdcf3..4b3f883aae17 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c

