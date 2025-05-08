Return-Path: <linux-kselftest+bounces-32685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E2AB05CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 00:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB684E7E4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 22:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F42248BF;
	Thu,  8 May 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Fvs9jJjC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C1220F27
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742024; cv=none; b=cppBDPeczKA9GvhPFJu1il1z7BaazDyfdvRGrZXMF0K6uLTbqe4m/DePe0+7QW9oRm8wvlzQg0JLT4al+uBXp7SL1D5B0X9D1yNAwGT/Y0dnt/MqRtjSTAMdNHUvlnb5AbjJUwD3La5YqCc2lR1Eqvyy6R8afEOrlpJ3cShRziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742024; c=relaxed/simple;
	bh=383tmOsOwIYI+sEuL4lBtsooiMu54rXi0r4rNmVC88Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1aXaWGRj4dDH/UhIcdGm+QVOYN7dMqO2QeBioRQBfbZcQDgQGPNV2tqXhsMOVy9JUNV7GgvXE1f6rGOoznGHQVQTGSZLaRLc7otTqMHveuqIbljV1/InL8TIdLIVjimRjlpasijnKzfBt0LqpCXfRJ38FqNQyg0exaMLTFV5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Fvs9jJjC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e5df32197so17048075ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746742023; x=1747346823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YygRvJatc+ZX+R8V8t/EbZhKaAFDzTF1VLryimoeTCY=;
        b=Fvs9jJjCZA4qvkKIwgp/yztqSEnSgTkFenWluSNhjWThIue+Fx0Wm8LjHVcCnJTNIq
         l8ckVV7njOMFoFJboaaUMW9kePx/pQVy05RuXebXf+bpTP2M87dKmHAZqPgPGe9WmPBm
         UTOAhhtnzuPMaphYuaPZvOQMr7726Cfh8IlsiyUgrSn5NcRnE1qxe/8bxC/ywng42qGg
         nio4h6jRGlDHtctDpZjwoKu/dEMG8QtnmwJVEcf071MELCu9eiexqPvcn5XYJtLePOMv
         1xoNR3RIb75M1BkeLTXLLDi20laF2E03c9g308INwolink5IO/4wiOKjG7eNw38ayo+a
         uYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746742023; x=1747346823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YygRvJatc+ZX+R8V8t/EbZhKaAFDzTF1VLryimoeTCY=;
        b=D/v74VV0WXVWyQC2g4TQwO8kjZspTYTF3RBNyFfpcIX5Efr1xulpKuCnlKK9PONJ/X
         Rd1GuTVuGmGc/8sC7eSrDgg7lLPgKGJ5KDZsXjiARpjh0WWxHuxqVx+YPr+pVlLC95Zp
         YEPNNHwybBdNuxVwOEh3Av7HHu7Mi1kt7l3aUbNp2V90KIODIUW1sv1FtJDI2WlMYIfe
         7ByW8+Q7SxXIKfNOtYXiBxBdDpBxXsstvEjpYBo6U6SzvyXuHIQQw/88UtSSHGNysPpm
         UvabVjOslpt4xWKo4+SO1bE5id+QuE8jeBkERzGefDmcsqK7eYv+dLF6KDsR8GgL79k4
         ghcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf996+9Oq2cwENwpyTOucXMC+LrDT5Fzc1d1aH6/XYoQwpuuqJBPnkXHjeUH6bwOl9oFsHclL9HlXMRcXNy4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzoZIyXk+7UOkm1NsAvwY+bKRS3g5olOTAAG73MtYfKgbYjAY
	tSZ6mLIsz5QnK8/2BmMtOYovARcWCgMgar65d50ooVfyWyTky83N+6IWbdyQY3U=
X-Gm-Gg: ASbGnctnBvYe9qI4JmwH0lEfgWLgyPeR3yM2y+cTttZx1zL8+6D02RLD4dnPFeCIsTq
	H3OAxdEGGRGDc7yEhUbbe9dugQ2zl+r9swB32XEsLy2IXaxFxebbdFHiE1Oc+WzdPYT8MDWwOgr
	IGrfgTQf+cvLKSJjPAwnxkEzU9wUjhEMVahmpaoe0LvG1R5mf0vmWosr9cYy4UsC9OHzFGncJDb
	7cBSBCa/PVMkUrw/UulokNJmai8d+HMXBbNTJtS+z/fKXJi9mVrL8vKPUcjHoaveLeEZsnGeFBT
	lcP+hu7rHCCIU4t99H08XOeIdggee9a5To2jzI3j187KbrRv1/dpqoP1OKmypu0jCclv1eTooQZ
	sDu8=
X-Google-Smtp-Source: AGHT+IFDbySgvmGLH2XmHKIsynb+ZCgAYVd6wTaGIi1rv2a6LbtUmPB+B0JLB6XZqjrHPFrWey94Vw==
X-Received: by 2002:a17:903:32ca:b0:223:f408:c3f8 with SMTP id d9443c01a7336-22fc8b41077mr14475565ad.14.1746742022673;
        Thu, 08 May 2025 15:07:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::5:2fc5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7540056sm4813755ad.23.2025.05.08.15.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 15:07:02 -0700 (PDT)
Message-ID: <6f40402c-dbef-4eed-807c-dd0ea5438732@davidwei.uk>
Date: Thu, 8 May 2025 15:07:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net-drv: remove the nic_performance
 and nic_link_layer tests
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, sdf@fomichev.me, mohan.prasad@microchip.com,
 petrm@nvidia.com, linux-kselftest@vger.kernel.org
References: <20250507140109.929801-1-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250507140109.929801-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 07:01, Jakub Kicinski wrote:
> Revert fbbf93556f0c ("selftests: nic_performance: Add selftest for performance of NIC driver")
> Revert c087dc54394b ("selftests: nic_link_layer: Add selftest case for speed and duplex states")
> Revert 6116075e18f7 ("selftests: nic_link_layer: Add link layer selftest for NIC driver")
> 
> These tests don't clean up after themselves, don't use the disruptive
> annotations, don't get included in make install etc. etc. The tests
> were added before we have any "HW" runner, so the issues were missed.
> Our CI doesn't have any way of excluding broken tests, remove these
> for now to stop the random pollution of results due to broken env.
> We can always add them back once / if fixed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: David Wei <dw@davidwei.uk>


