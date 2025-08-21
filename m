Return-Path: <linux-kselftest+bounces-39481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF7AB2F8D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01F61CE28F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5C311C29;
	Thu, 21 Aug 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ydnd4lN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781F2F4A19
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780258; cv=none; b=QbvRKPeg/gvgahVe3mMNlj3TilvHxtTzfMvVPn9KDNyptVG9M8r4SHfp6Vd5kREgVu7xSOZlORTCvJlWnTQKs+U7madHLpF3vPZEthxBC5lWl5UWs901p68miBphr2WJ/P5BEPEoKb5laiNxy6sRKbNdSuqS/9AbGsX7I3Sqhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780258; c=relaxed/simple;
	bh=kh5QYdAh6nAxq3wHVmiK83eqHqd1Ae70oDTSD42Qpis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iVByoV+DEH/0eKNz9gk8w92sb5MMJSQT0Ko2cR7aWqi/+Ye665ix8O+dlu7Ss+tlQ5d+xr9NM9D4FT3T768OK4iB4ODtqRnHvXNcw2pU6tbO8qXr0hIZkmVXYfE/KFcPVscriokgCIL36F9MXESFYJyzJe9jFRqd7g6HBPJaCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ydnd4lN1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b467f5173so6534705e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755780255; x=1756385055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kh5QYdAh6nAxq3wHVmiK83eqHqd1Ae70oDTSD42Qpis=;
        b=Ydnd4lN1En21y6x+e1isqj/cIcMMtWZFAQoxdfTfR3Ym8KmNOLjq6P4ps5EriWuPyC
         zeZrvnt7jIwr1mMDp3Rh7ilssQTysRVB8T34OHZpEHGbUgUDb9Rmslo92YSNoam6VvkJ
         ZNpWxXg6XFOanGpr1uGgzWPT0HxVjsooRoei0sSQNAhUaANqcc/FAVLh34VyLmIMEZDm
         kN1K8ms3c9GD3DjAua4s/V4TYENif3m0tqO6CkMG0rxx4QCjoyXt3HxAdbQfSsErzAj+
         bzNtq5+gXk8h+xPkNlNj+JVuwFA8HIQzrbrJk7YEzDPMmjn6zaWR9owHnz2FAZQt3Csm
         eNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780255; x=1756385055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kh5QYdAh6nAxq3wHVmiK83eqHqd1Ae70oDTSD42Qpis=;
        b=jYTtQF45mkWTWuELryLAykhsgu5Mncr7C0rmbu4f0b89c1pjRLxnXD1ZV2xt7VS1Sr
         F5kagg7WlpidodUjF5e19Opf01LO0uvD0fPVb4pGUI2qkRpG61VltnFhIhpIN65WqcM1
         GzSLlUBcDXy0byBu73SDpSz/CvIw4RyaQaD5hoo4X0qqDEy3ucfYswU5BkeSiGZ9eCin
         9pjpBqZKLjXo6bSQCfB8JK0pNESVMhUeAK5Qieu0EbG9MjQ6WZQgwiflUPAbg7tA+E1B
         zolgn/1nY96jDXPzooJK1GyjzsAfXVVoqStJ5ouyYIJTdUa2KTViLDlfahbMsJQRsFqV
         MPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeu25Zr/8DeTTtga5i2ECP96v62AH/lTvIUVO5KZTgpPL3TOmo5KB3nsBedQCidQckBh58n95GWkKWKoF0Q+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vvtKriSmwhLIszuGOCVAFmbedEWeibl7uf+BRNixX7dTJvsV
	7aEsm65J7rCJzioLsEyk8f4xD/wklvWYxanO50bXClI3yxG/+ujvu7vTqPENQxvgHt+Uc1NrYNs
	ug2SdwmDE2o7lAQ==
X-Google-Smtp-Source: AGHT+IHAROi3MrtrJw/aU/9ZmYqp2tOlukwY3bYbBdELumt2D0HPjVm8FpMPMoJokOc2rHfbgvTz5uNpauUQ3Q==
X-Received: from wmqa19.prod.google.com ([2002:a05:600c:3493:b0:459:dbaa:93a6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3541:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-45b4d8587a7mr22616175e9.31.1755780255050;
 Thu, 21 Aug 2025 05:44:15 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:44:14 +0000
In-Reply-To: <20250817065211.855-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250817065211.855-1-ujwal.kundur@gmail.com>
X-Mailer: aerc 0.20.1
Message-ID: <DC845LPNX9EW.248S4JXKRUJAP@google.com>
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, <akpm@linux-foundation.org>, 
	<peterx@redhat.com>, <david@redhat.com>, <lorenzo.stoakes@oracle.com>, 
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <shuah@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun Aug 17, 2025 at 6:52 AM UTC, Ujwal Kundur wrote:
> Refactor macros and non-composite global variable definitions into a
> struct that is defined at the start of a test and is passed around
> instead of relying on global vars.

Hey sorry for the delayed response here.

Based on doing a range-diff vs the v4 that I reviewed this LGTM,
thanks!

Reviewed-By: Brendan Jackman <jackmanb@google.com>

