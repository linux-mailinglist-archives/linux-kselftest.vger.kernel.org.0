Return-Path: <linux-kselftest+bounces-48463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 730CED00A1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDFAA30970AD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79824169D;
	Thu,  8 Jan 2026 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJX1LB5D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6F238C1F
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838373; cv=none; b=rS+IC/C9yKU4Vrm7g9HOPMpghV38MocfC+08FuFHN6WCHhwlOKnMDNA2Dnx4DZTTXCMQ6WgW5LtbuNF5K+DUb48U5HG1W2WGLf0lLY0fgCOaM594bvgme66TRN0d9b40hdwdnYpzBQYsD28VJeP+abtMd9QKCy7SgwLKgScxxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838373; c=relaxed/simple;
	bh=hF9d2rhNnBS2loGttWlljpF0c8tw3NNkNXX8fEqJveU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csd6tHMSyazGFflTWQtzPgi0mUCge/Vo2+0O+lrTrr7lAzvDlqsUcOy4nNEiwvdeXgKgD/EvBTWFrm7SzAi/O+Pp5CLXzOe7XFCLBkqh1qMOhzJOFgHTUo1RbTLWWZkQU1whxsvOq+8Jq+8O2Sv5alngmXRr0UB5z5uJuePcYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJX1LB5D; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1205a8718afso2522690c88.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 18:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767838370; x=1768443170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc8PyghtvdlRSO9tPpEj5myMC/2Orvga0lvG2eJ2slA=;
        b=TJX1LB5DkLkOGVn+5vg3qW3o6Blgb81dMGtSQw94DVnf1QgpcIkkzHfYAuUJPsRTYg
         hukuMEeqw5c860w3Fcd809mEWR2MStHmCxcftnurPBDiBoljfah0am6qRXPc76mNE6Hh
         9cnRLNHxUZAPx16S5pSA03ICjx1q83ZWlhGvNmZLhF/92bU7X2KY9tGNS753VGOVru/R
         z8SnbzACbO29SlA7BFeR5rgd+tQUDyfdDNhlHH1MDQEhUErhgGAYPIt9UrsnyD3JvTHg
         AgXwQdjzU4VDmJSzvtw6F/xcEPg//2Eg+tx5qGMVp3Kl8sJxFYxSHk2YgYvlHFXdRy+n
         gwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767838370; x=1768443170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dc8PyghtvdlRSO9tPpEj5myMC/2Orvga0lvG2eJ2slA=;
        b=oX95QXBs9sGemE/y1H0f3xd3vsDWYOc+wI31Dt6gNBw6HHlV1idhy9cmMKwPYOuPti
         jntsUHbgzUrlvi6gwiYZbL3bmGN46t/QDj4JAe8W953lEswP7kZ8tOnuLCeglBOu0cka
         +JZSD0yAzxeI1xoTEocf+ypX5pRDC5FqwaFr+24FP5GVgj83p2OGJeCqttBfPrsEwBXa
         Li0/b7BnBtlAOG9HsQEzO7dKDeLjL6fwODWf9HY3phkrPMqD+cneoS8Us5mfA0EFuTWN
         xQoWIF1VCjTktwnSQbp/gHJkVML8hXx3eH0GYRZX9pbQ6i0UmiQ3welJX1zk29rJEG4h
         eVrA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Ezh3RzKlcvYMzZf9rdk+bHKj9DGgJxvx4BeDNLytknkdgkMZJmuCzSfGd8K0QsjShKBKKynK9LAuV4i7r+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyobsvGnyVbVhwdTwXB4TaXy5z/JHBQu9UzzO1FZlWfGncrpcUh
	sEi35QVqTeU/nMYr8drAGSge0FaopQry5TUrxDRfb+KXdrOj4iSHCPRE
X-Gm-Gg: AY/fxX5SKizeCdlP0GN15ViuqNUwlPFkMbcEgESfK9EWqmFtygiyPJhE2r32M48gLdZ
	56tbCuc8TW+kfMkcxKOQc8Gpq/qCeTZOX8N1UU0EEu222HZPZC5eG5pzxMex/3O9oqwjIHX+qMl
	HQLMfod747UJtoHZGDDz+MgFe+QkBFGHjZekQlB44RXdehtCD0/1RjU+RHENBSbuoJ7isKB9xOZ
	FvDgb5dL7NqoyXqDyE//batI5Bk+nrF4ETp1qw0XuAZ2E16qjPU/whtBvjDgJ0GDXjitB/NWXSe
	kcFGL4tLGgVEiQXfB8zo3FNPgfqvNEeecZq8UoQK+utQE2nmMTe6K4MkcZBxUUE08eW5wDQQhtk
	Lwn0y5AQor0llNhhovb2PvilQrgp8LWB+OAIYoV2wugycPZ86wNk2Xai/tZ6FLQ+ej9YWAESoWM
	RU
X-Google-Smtp-Source: AGHT+IGdu6VmZnIPKWkx6NXDLXAf5b71hWdgf0gteyqFBNplDYTNuYVytmH61SR9H9IGtnHEZB9O4g==
X-Received: by 2002:a05:7300:fb09:b0:2a4:3593:466d with SMTP id 5a478bee46e88-2b17d226c06mr2746197eec.9.1767838370366;
        Wed, 07 Jan 2026 18:12:50 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17052dbc7sm7933292eec.0.2026.01.07.18.12.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 18:12:50 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: kevin.brodsky@arm.com
Cc: Usama.Anjum@arm.com,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH v2 7/8] selftests/mm: fix exit code in pagemap_ioctl
Date: Thu,  8 Jan 2026 10:12:37 +0800
Message-ID: <20260108021238.46605-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107164842.3289559-8-kevin.brodsky@arm.com>
References: <20260107164842.3289559-8-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Make sure pagemap_ioctl exits with an appropriate value:
> 
> * If the tests are run, call ksft_finished() to report the right
>   status instead of reporting PASS unconditionally.
> 
> * Report SKIP if userfaultfd isn't available (in line with other
>   tests)
> 
> * Report FAIL if we failed to open /proc/self/pagemap, as this file
>   has been added a long time ago and doesn't depend on any CONFIG
>   option (returning -EINVAL from main() is meaningless)
> 
> Cc: Usama Anjum <Usama.Anjum@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Reviewed-by: wang lian <lianux.mm@gmail.com>

--
Best Regards,
wang lian

