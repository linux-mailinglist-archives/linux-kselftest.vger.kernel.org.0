Return-Path: <linux-kselftest+bounces-37885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9400B0F838
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9871C2151E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6C1F560B;
	Wed, 23 Jul 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul1xvIDl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2735D8F0;
	Wed, 23 Jul 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288613; cv=none; b=rGAJQXhWiYqGKTlsyNKLsi195XKuQerXdBtbFHfC1/u1ZNLLRvS/Q3399yvho/LaSaBUmnwLk+K29NoBP99sEP0inb4otrVbnP4RsmrRyZCOKdO5imy2rkuNpCjFFfg6r2xM5HsW7uvndq61hyCz3wElHGX6OLCtFDoGWE8z2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288613; c=relaxed/simple;
	bh=1f8s1MMMrZUXY7HNFqhbV+FHixNlT6w7z3HtgLFiyKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmh8VPhjGRgcC6+2x6pllUuBrnMqtRsm3Uhb7QIe7wpArxFR6EvmoBp8AYdK987a9s/pZAcI5/aensdQHqPxcAgIEG47aup0y/1DpRCuxb7G7l3gM0bU7rlDW7VKeU69cxBkK3RiYEdoMzOrWUmoEW5MYK9D3xNKM1IYrpGhUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul1xvIDl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234f17910d8so46145ad.3;
        Wed, 23 Jul 2025 09:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753288611; x=1753893411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fx+A7/q6ZUtKDHiMJp4IBXILWaz8CBy/vW0OU23aX7I=;
        b=Ul1xvIDl4uQsaTIeC38ZOpgLApN5cQhlYMmC0VxO+1YbtuvnHe4yjpZQNLMpBdn8sf
         Tal6nhw52GTlDveMfxrU1KkmN9cuIjPs2gl/jr9YCfiSpg273iPxag6nwmTCwDWNqYCL
         UcCRBDjzYi4CB6U1SC/JVSSqZgKVMHMCcctF3zkzjhXm9YBYO5f6yTyQOAKklHU73Kaw
         19ksiibtdpOQGTLZ/2CREiYYit+0CGHuFUynbn+Rp3lniWjzXB20zs1rcY/d+XiA2lFv
         jnqndquCIHxDNZT/jEQak2/8u9LZW22+EvTi7PQYFqAJdbPEzspkQziDqH4gHLzDwpry
         zMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288611; x=1753893411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx+A7/q6ZUtKDHiMJp4IBXILWaz8CBy/vW0OU23aX7I=;
        b=i+Ik+cijHSimowq+bMfBwxtRo9PT7dPdByPkZCm/9jiokaK3qA+qE/Owjed3jCskMY
         UPCkBaz4fngdKpXDtMBm1AU+kLp0nRf6X+XTqzuwAg+5pb0t4t41YrY+Omguc1RLhoWL
         dUt8v+ITZNwLkMKoSq5BolMaMnasDML+ei6sQessedaeQEhr4aoAARkRK4SfwLmZIYN5
         L2nvqsxwpKvFiQ2F786eCx1qkCt2soX/j5TX8UlNpCDZvDv/wg+A7Zy9AZ/Hnn9NpUo7
         SMRVULR4yF3ApYqfMvTFLHt5I9kCrMK+bPUU3OrOiYTfMjSSx4b8TOQHhqTI5kQvjXoH
         iRjw==
X-Forwarded-Encrypted: i=1; AJvYcCU6GcX9mSbTz7p2xrcSot22SF72UAqKFZgp0b4Vo5tP1Mn6wue1FWfzugCCW5H5GZNFIZcyvH8aShY0HNmk@vger.kernel.org, AJvYcCVJdoC068d6NrHicbQNtETliFuXtfHNhNDxiL9RmGcDKP8u1sJvWt0/x6w5y3J1fsUD1i0UrHChuRRgTSi4c12N@vger.kernel.org, AJvYcCW5mZ5WmJHvCthnl7UwOmBAnZSPplvpopDLVtQyDUk49730HgvyFQNdyO185HOL4jcAzIBSQL24ggWkV2HRSUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjEaFx34PvhyU7i5zg8cq6pCUxt7JSzgm/vuSjanW6NSK3D41
	Ho/D0WDvi/Ng6kNhpcgsilDk1Gl6i0bnVH4nt7BXRboYGZTxnYCocMxT
X-Gm-Gg: ASbGncvFgrRHdHHt4x4TvLBCirNwJPNKk3z16JOAgWPbwUceJAQT66gcDo8IKCaw0+o
	RdYxfhwwpqvFiFcpqXdU0hbrtF0NRFOsLB2NjFP471YO0dXhnlDg3cDYSStAlRc0Jzx8zQaYE+j
	yeklX9veIWAH8Wl2qpBEVIHeE3Ol380ybEw8ZrVSquHN55eYxThWeDT0W5UxB2AFhdzBGwMqCgs
	gUPlqxAOtCK9Qu5ZJ7elIavyGJA+bg9yrmZr7Gf7avtFKB4M9g9HRqd3T+LMrt5tcmNnosyp12R
	DFvm5XUkiBTQmXK5l894Hhe+rtsZyJfPpNz48rK8Cqq1k+VMSVvpDoDEOWPsODO+OsUh79e0QOh
	kTMLI9/dp3JAPC6Oso/dCf+/YdBKGgn7VJqfOQLh3CQcM2CX0cU2Qgw==
X-Google-Smtp-Source: AGHT+IF+7PIFIwxHxFCd3fmVGl5Kwhq6RM7BuCanshOuUY/aXQHU0NqUgVTlYaxJn03calPDpIPI6w==
X-Received: by 2002:a17:903:b87:b0:235:f45f:ed2b with SMTP id d9443c01a7336-23f981619c9mr51840655ad.1.1753288611270;
        Wed, 23 Jul 2025 09:36:51 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6f2306sm99985265ad.213.2025.07.23.09.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:36:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:36:47 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tools/testing/selftests: Fix spelling mistake
 "unnmap" -> "unmap"
Message-ID: <aIEPn8O2z4sNB74l@fedora>
References: <20250723095027.3999094-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723095027.3999094-1-colin.i.king@gmail.com>

On Wed, Jul 23, 2025 at 10:50:27AM +0100, Colin Ian King wrote:
> There is a spelling mistake in ksft_test_result_fail messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

