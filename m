Return-Path: <linux-kselftest+bounces-45642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E691C5D45B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 14:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AB3A35CE75
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDFC245012;
	Fri, 14 Nov 2025 13:07:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB21E7C18
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125664; cv=none; b=pc137JTJvItYjL/ttE4EhTBdiISnB1pA+ZXaH4j9VL85t0BANEB2obGVH1FY37vMrLSvzn9zyfvomYFg5GLQxNGDmu5SoNxfuUQ6Oma3MaOjIHjUV6XRr6gpORS8uCPYfFwP18gS06XvTkE/Vfui4D+hx13ilVhBQdLeaHTIR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125664; c=relaxed/simple;
	bh=XpRgNctZogZPOyMTctanQfbuia14WJM14QLnFQBVIwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmtD4i1Ty8hoY1mY8zwOSsO27nZmYkddvpe4JePqGOqqGWprbIOsp8XHC0zlQdFFduK3oc+qV+KaE7kAyCHxyJRkvvJpn8R1sRgezim2alRPbAocYivFF5aPly8jA1ZN6BGTGljaSclDk65lQxCoWmezD3c9DtKeNHlPSreZ7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3e80c483a13so1301189fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 05:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125662; x=1763730462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scS56hyiFjjliv29GEv9MnQOfltcbJ+rafC8RSzG4ko=;
        b=SL/EFCJs3hiw8PgOcp3WpAwM97jAOgTz3ZG+TuOlc2wFv97sqXTC49vaHeQgDymJLE
         SW5RPw32JXReD3zm7+Bg4uYo1oZPGNJYsXA3m9E/B11g66b9d0ctnEXBbPWvpIzQXRam
         9XUbj+QRbAQ08po24w5Bubub249Rtem8YRlyE2ePUgZp+pLKheEQzsDzPLrJ2SD3GqBN
         MWZ8J/r2MrmOouTZsmBOrSGxoFn9SwGhO19TuoQ0l4aFBM4szTUn0TiRiQtQ6m5Aefy3
         fAtzxCGwOCTSfTisjbXSTUw+XL0RA+PkkQ+P1x9F/RqZsYtMVr57vjZXIRSk+GRr2lYZ
         FaOA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+fC/OgrJbOoXQyED5+T+RBNukmGTiB6WWAoP+PyQFvz3m/8qclBAkgwQV0602PA/dPZ4tPt6rPalv+5Wqtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYDmUfwczddWNqtH64y/KMvA8Oc0QuRDjz8XWHbwNUOt+khfc
	/iybLnerxL+dqENLBgMq1MKNMMX0J/5aAcLXB/bv/ekR2Ig2eUyyKGRe
X-Gm-Gg: ASbGncvj0wSTfHva4cLCkeIhxrMxQdxhRj2kXqeAIPTngCZnoxAxJ6LdVei8KAxJzeg
	Aqpj8IQAwonBrHVVO+bsjEUO3mQA/vwAnwtLeGEdfZMFwmH7PBZYEWFVIS9k1TChTNU3SuFT5xe
	FedCEGwSxd/v1+Nr6Gf9qQRBcMji+RpLIQvKvU7MqWfo7iQTnY4XghNaIJfNX3DgfJ3Ja9DUz7a
	E1iGsOtef1Gnx3oiOlcwPKP09HLX/zUxBL3gm/aWLCAoVEDSYi4S/bHC11T8wZNmG4M9wUjCR5G
	PkZRlrYcgJhXQ+z01U+KR1VbYqqO0nwVSUMnP3OK+7zfl/AfJRY+IfKKVKrGrKEbl8+mfF6wbub
	U77Og4663xeKY6IETxHAPuxUOf41TE7LIZSvAz25Jwp0e62OD8jFl72Vpqi6m3QQ9cFzJFaaGP3
	RjQsQ/zqCpNGUf
X-Google-Smtp-Source: AGHT+IFLGoBhM6cR+vHZSkMlkU1qmRI32euUR4PJIhFxbKjDVZay/th8eiP1k9kjIaBNsTgHuOmBQQ==
X-Received: by 2002:a05:6808:1508:b0:450:9f5:dcbb with SMTP id 5614622812f47-450973f9bb8mr1304172b6e.22.1763125661654;
        Fri, 14 Nov 2025 05:07:41 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4508a6d7b24sm1967935b6e.21.2025.11.14.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:07:41 -0800 (PST)
Date: Fri, 14 Nov 2025 05:07:39 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Message-ID: <v4xuuka7oovpcmcw4ualj5mdhw6jlgtcdheybbwtuy7qhd6nyd@3kav6dwkkdac>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-4-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-4-18cf7fed1026@meta.com>

On Thu, Nov 13, 2025 at 08:42:21AM -0800, Gustavo Luiz Duarte wrote:
> Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdata
> buffer is allocated dynamically.
> 
> The previous limit of 16 was necessary because the buffer was statically
> allocated for all targets. With dynamic allocation, we can support more
> entries without wasting memory on targets that don't use userdata.
> 
> This allows users to attach more metadata to their netconsole messages,
> which is useful for complex debugging and logging scenarios.
> 
> Also update the testcase accordingly.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

Please expand netcons_fragmented_msg.sh selftest to have ~100 userdata,
so, we can exercise this code in NIPA.

Thanks for all this patchset and improving netconsole!
--breno

