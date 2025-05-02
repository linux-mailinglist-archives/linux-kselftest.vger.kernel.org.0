Return-Path: <linux-kselftest+bounces-32175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F31AAA71BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BDE3B8AFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D286724BBFD;
	Fri,  2 May 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lp7N+0rs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F96242D6E
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188906; cv=none; b=SBvBzA9WPnxEuG7N6Uk7AEfloPYa8TFLv323gE2dC8YAuobCD3YcTTNtsw2T7rM3nvwjXKfvZEpNBkFIta+DlIoJe5wUQ5I678wv+h9BDje99ix+U68zS15pYSQVovgncyD16IjfsNJas12+yfVTf0mYYO4AZvKHiT/I1rHbyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188906; c=relaxed/simple;
	bh=zmh526Lnl87MPrhQzMnGE+FlZXPEehb2CwuFJUvrAvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSeap0ADHZnjraJ0fKfIlEYRFgKEygmYsNA6MQYxdc90ZGSkJwnlYdS49LHahdxjsWsOkDRQNdNBbrVKlRAGiLV8doEEDHM9C7LNXmTOj5rG+HBtHUy2+DW1OvHhrkOAEmeDeswkhhBuiJq1ZIkbsiqo1YNgDgEYzHslqAupjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lp7N+0rs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2242ac37caeso97905ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746188904; x=1746793704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zmh526Lnl87MPrhQzMnGE+FlZXPEehb2CwuFJUvrAvs=;
        b=lp7N+0rsEJjdMmBMND9+LIiCOcDNaDq7waS1UyQUrw10mwKcUOl17wdNDMtAvy8L7w
         tHzI2250VRdlwR4uSZiiDiEAdS865WIEEFFhtc28NBbEzWJqZ2f0BpLLUS+njf9Rp5UW
         KE+wlopFfK8/uIUq6lvPfMjCWhZYtJi6IzAG7olhyeqMpzh/FbQGl9XrH7gfFnZX+BAs
         3j+YnDvsyfLiM4X6m+NSVPOgZNeNogM/qZEDd27RWoGt6ci+CKYr7H6YvePRRCFYP2Lw
         flNR1SsE2UWUqRrvUXZl/34k41G8U6GahkwUl8sGbITStvEjikQU6zz4Cm5+TFZ0MRTB
         4Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188904; x=1746793704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmh526Lnl87MPrhQzMnGE+FlZXPEehb2CwuFJUvrAvs=;
        b=Vrfzkw2U4uYstV4rWaDk2T1CDbUYLDvpMIAVLjA9kYqBG03gZMBiu/NJvjBHE8AVbo
         4t/LZat0xDL2Giq4z+1iZAVExKm6o98DgB3SPxmCQz+W/ap7E4o6e0aTvwVTX8cG9oTH
         rTISMISsn86XdilvGuN865KeXkdkVgI6Kb9le6VZcWow/FLJB0BET6LJl0cr5J5c1XXU
         djf68vEVx8+IIqNfjTyRgtsyjCHgQjQz8YryRh9rLsNjPCkfDdc+j5FiosVeXBb5CU7i
         VPXMiLhqefJiwVBrjEBnPUADs64XEiY4yf5as1j4w+EFzRN7eSIbCekLFFowpGyiAYsq
         437Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY8Erw7c/VznL9p29B9NkMpptjA6jjRwuQgc15ALHum/s364J6j1PmoxcUkkR5/cKz87hUpwWpYetMvIRWoEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMJRln7g0iWomMn8Qya3OETsEhfMJf8tJtyatlUYgSjZAjVTm
	7oAhT/u5Ph4fmcohIFB72VWp1pKbC392eTjH9A9hBj32kozwNDTEK81y8lycwdrcc3o0+s3U/MO
	D3PfP7v+B/OzFot8MAP34h4XrWYNmdpX+b4Jr
X-Gm-Gg: ASbGncvhRQ0J+eKsvzsIiJof9jMMqXl8B/6Qf9qyJKOCw44vIiP4quMkVCCQY82QYc7
	TpePXUeOy8bJex09XKSSWqcrx8mdqTZdAEsLjRJRBPeDcDDKNMI7BAMh+sD0heXPUZPy/l7qTMT
	QqpRhpow8ON69hymtwzDw=
X-Google-Smtp-Source: AGHT+IHV5VcT8qrVNy0hr0jvUhSwI2dzYIiIIPkfLEO6b3DLFwV4/3IH9Q2Vd9a3EkRHSd6EP2O2Joz97r+Cabv47lM=
X-Received: by 2002:a17:902:f24c:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-22e0797c6c3mr4184255ad.9.1746188904130; Fri, 02 May 2025
 05:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250501163827.2598-2-ujwal.kundur@gmail.com>
 <D9LO1QI65D6K.NLDZ4RK2835Y@google.com>
In-Reply-To: <D9LO1QI65D6K.NLDZ4RK2835Y@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 2 May 2025 14:28:11 +0200
X-Gm-Features: ATxdqUGJ69Ia6WcMuCEFCnuGbd5YAV_Udy5i81oo77n73ry6AVBvmtLYMJeu35Q
Message-ID: <CA+i-1C1x2TenH-WxkUnkx3-5XpkXOMMmZQTCBV3sHDV8WWN=oA@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests/mm/uffd: Refactor non-composite global vars
 into struct
To: Ujwal Kundur <ujwal.kundur@gmail.com>, akpm@linux-foundation.org, peterx@redhat.com, 
	shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 14:16, Brendan Jackman <jackmanb@google.com> wrote:
> Little bit of indentation mess here
>
> I don't understand this code but since I was hurt by these global
> variables I had a look over the diff anyway, it LGTM (aside from the
> formatting nits), thanks.
>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>

Wait sorry, actually, this deletes the global vars before it deletes
the references to them. That's gonna be a real pain for bisections,
please can you restructure the series to prevent intervening build
failures?

(I.e. if I apply just 1/4, the selftests don't compile).

