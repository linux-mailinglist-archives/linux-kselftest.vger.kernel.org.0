Return-Path: <linux-kselftest+bounces-27893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD4A499C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD88173BF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB225E471;
	Fri, 28 Feb 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HF5j9Lu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7458468
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746869; cv=none; b=QX+2sSjaic18b5Rpg88eXixC+zMUV5sB4MstEnu2iJl/4FwfdAQ3M8hwUBUxxcov9O3Doj4WT+pKpQYRArf/bTkjj/bTfw3IgXmjsfXu+ncOknnVOU/3LhN0N5Y8tTgyHHIT1EMfmos/etegmNW2lXk/s3UommaM/lMTCw3G8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746869; c=relaxed/simple;
	bh=PWERo/5M2jb9hCdPYwTBJ1qg1GnJybAhnw/RWv5d8fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVVuDmTH+LtwISFLd1a8QCVKKnGKOeIwktnG1avjH4y8D5+AzTN9C6St9zaR6aZTPOWVEgKUbgSAEI2+xf8eNjurmlDgbjDsOr+OtaFYDk9G+btMvslrYB2pMie8Alo8z7Tebs5pBFNTZavQudzw1stZ8FDPtyrk1Ufa/02ZRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HF5j9Lu3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-472098e6e75so200761cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740746867; x=1741351667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed09H735YaLqEmSd4YsR8vzAdFaMM7r2CSHKqIy77Gw=;
        b=HF5j9Lu3z0uJ/IHKlSKX7j6bJWSfyQRkClMNsyAxEUZhOW6xIBO94MusDtA5I2VPd2
         bnYJvWbPpTjJENYMraJM7zhefv2xjHxjBegNcJSTTczKHTBWzP2TY+UpKmk8KukgQ2Ea
         o6Q0qKGuZkebKPOors8I0dddoN3/27urgQdnN99PiXUeHbRWSLdgem5GcduVM/DZjtKI
         tJVU1Qprt/yv8a8qpkfmQLqKnYDexvJccHqN8mrFTX9jUJQuZYwIOI3JkZ6y7/5PFcKG
         htNT1U4JU/ddMsxhELB+xt4y5h506QdesnRS0mZI4JVLB4+B+we/rUHGJhkKcNVOtYoJ
         VLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746867; x=1741351667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed09H735YaLqEmSd4YsR8vzAdFaMM7r2CSHKqIy77Gw=;
        b=Y5BN/FcRi/e1LdV8ul61KEE89mIpb9WThQCAwSWInUNrFGwFyjN/jOG5iwxtvurJ5W
         gF2dQPxh0j/vmMsOYz7S9Dnu3S+lbYd4igE2qN3F/yVQTJ6AVg7mHO8pGuew7IZf+cPd
         y0QeQ9SjdFdjBrVIoFrE88y+rbO+q1tfVQk4IAuD2kWDIkNiZDUoaYiL4zr3xk2Ib5hb
         eLT3AemngYdDJXEMrdkOzykkYuqjZtReO2ZyBDwnDKsaUojCwj0Gtc6gT6F+KVClO1GN
         i8970slsa1QQvKxOvzQLJYBjh9xsm1F1gVGSU0sR9dEWWF7nZ+lCUCJb4cSQtbeiO0pO
         kc4w==
X-Forwarded-Encrypted: i=1; AJvYcCUT6A6nLe13DfudGmNLmLK7BCxbwFG+wJfufqaty9fFccwPrILALXbvs4cWFwK6JW6CkkkYXhdec4xC/34Dmc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNIIqP24h8H2QvkzB/Y1RILmJ115rexLzdbc+yL9APnj/so4e
	1qeYQRszWV4/Uh7nQ1gTCL1DSig9kPi+3LzmmDOaLtL8dBofQwFQ+D1+lkDJzQH68RCInTWvpdL
	ZWaFrPyUZTYxGPDaVqlblmsx1VRXwfheMLHO0
X-Gm-Gg: ASbGnculKJS1ibsAupDZU+kxK0RzzLc5EJPnHhkVk3HrGjMsVTBglJMX/qhVuqDzJQk
	AN9c69IGyAR0kPFXkvwWhxeqmaOCasNMz5xxOcHRGS9cImCMjHG4fb9sdRjDZqePE25dPamrTp9
	pzQdsXe7H4E2CMnGZm4+9oQY07SCVr35pJaBTXGA==
X-Google-Smtp-Source: AGHT+IHAYWIF6RIeNLyEuys4z5PBQSKa6Alf5I9MrJkp9EZgDcaziDs2p2jX47RmrCvijeFRV97OOeBVVhw84UVpB98=
X-Received: by 2002:a05:622a:14:b0:473:83d4:f1f8 with SMTP id
 d75a77b69052e-474bc1140a7mr3500371cf.20.1740746867062; Fri, 28 Feb 2025
 04:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com> <20250221-mm-selftests-v2-6-28c4d66383c5@google.com>
In-Reply-To: <20250221-mm-selftests-v2-6-28c4d66383c5@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 28 Feb 2025 13:47:36 +0100
X-Gm-Features: AQ5f1JqVkRaikeTHI3gz42KwjbOjabWHUukhsdwdOqHxGKv2Oex2PiSl7mtPxuM
Message-ID: <CA+i-1C2RFVZovrxjYGA3i6+vuizkMkr-OXr0bEOQrBqRoAqQ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] selftests/mm: Print some details when uffd-stress
 gets bad params
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 19:26, Brendan Jackman <jackmanb@google.com> wrote:
>         nr_pages_per_cpu = bytes / page_size / nr_threads;
>         if (!nr_pages_per_cpu) {
> -               _err("invalid MiB");
> +               _err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
> +                       nr_pages_per_cpu, bytes, page_size, nr_threads);

Ugh, this is garbage, wrong number of args for the format string.

I think I originally had %d instead of 0, then changed and didn't
notice I broke it because it doesn't actually cause the overall
kselftests build to fail. I'll need to find a way to update my scripts
to detect that.

