Return-Path: <linux-kselftest+bounces-27566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFEA4559C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5371757B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F33268FC6;
	Wed, 26 Feb 2025 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHk/zuPa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8516C854
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551511; cv=none; b=D4O7kM82D4iYNPWRH73DXT1zaeYPpOwxuPBtbIPo5dp3lXYjIJ9tKzNHNgWah04bJpyn8SE9B9otf1gArnNgcYFUEeG661C3R3074J4bZ+MsJezPn32oPQL5zjU4EQIlHFq45xW+OnVaOjHmpcv66MNz01ihySAEzsXJIOE/pDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551511; c=relaxed/simple;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3oRrrws8ygunkVQk4pKAD382z6pLOWRhyuhgkc2NpYDMuC6ccUh8NgvW3IYNNofTbabZg7a9rfSKpP9P/s3cuqkypmTMO9Fyqebb7VQpeLCYgvcyl1QXPaLdY42xPr2DoZmPpgkp2gJMqaB0ZZuCvKXunWrAQPmzbcclxBYcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHk/zuPa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740551508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	b=CHk/zuPadTa8/06viBwSDDlU1nUZ/oS+5hxz6H4g1OkoxrIIcTny6DLgjAK5hbG4QWvl5E
	UHAjNQ7Ez66CxfFPB8rNPFr3VRAVH86B2A8HP2wI0wcpmKk4y+51D9l3CAhlvsuuInUHRr
	E/rmHneEOjY+8Qvf6R7Fw5Tt+FIsB9I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-LevbGwozP2-uarBGqFyxWg-1; Wed, 26 Feb 2025 01:31:46 -0500
X-MC-Unique: LevbGwozP2-uarBGqFyxWg-1
X-Mimecast-MFC-AGG-ID: LevbGwozP2-uarBGqFyxWg_1740551505
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fe8de1297eso102254a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 22:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551505; x=1741156305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
        b=L+t6hOmg7k9cJrp3llHC8pfqToWQRWGqOm4SSWa0CaLsHp3PGKNsdX5Tj08doXfDPA
         LhNNCcRQzVaRdfYLA9Sg2OB8KRyI5yleV/f9PavQ0zvsck8hVp3fVm9lEXWV0jSgh0kX
         G0IQCc7b1nNH0LXPRsr6tMMurhZHWpupgA7HGreGTcEPgs85a7t/opTjGbYwnCt89RrH
         vrTRFx9e03klWojezAuGXCwUsZdjBz5S+gKxPSuVUaONh+/qN+h9LqdQmPnlZ/7tnQDL
         SUhQb9lS9pAMBMA5A/t9bsNWAW4AsCqrz76KizKmIVHIb9piURhnromIw53n3EaPvsKi
         UAig==
X-Forwarded-Encrypted: i=1; AJvYcCVjwLDLNdQ0ajqK8m19Qh3vBGtFetrOPQf3DS75byhyGdQYxskxPPHuuMCcNjEyhX+OmSvn44jNgQU0e1NYVuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKoXJiYgXAyGkDFiinC/PTJph6zJbFpGML937zHejNa33u07f
	VKeKhS2LnKI6CPZDydNsL8J2aK1rLSBWbFCSoMttsl7yRtrh+J9JULhuvJS/fGjmen02pmyru/i
	EskjDNWuD7sCAIQJ3wXAEG2ZuQ11x4Ej/q5pGxdNAlahmIRPq0oTEsddJKN+hD7ysFQJxcgySFP
	02GC9/husQfYR432w4vwYi7nhZVbEmCqyTiEJarmbK
X-Gm-Gg: ASbGncu4m7x4KvVjNE1EXwbg4u6MiXIz2gg2EvZxW+FRmuqjLepeu1JpZFHKqW92IrF
	xHirnkUztVPbdo4exuDNR89Y0Bf1fFdbeDEmtMX2VrSfrN50EAWUVHtXCQdPDM3106k3O+zZSSA
	==
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-2fccc117c76mr44400159a91.8.1740551505309;
        Tue, 25 Feb 2025 22:31:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgJ5uK64t8Qtg0HyTf+eyJQk/RcSifCuXdoxenxtpslxzpKs5bezA8wPuv+n2H82B3bP4YRr7ay+RtusUhlC4=
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-2fccc117c76mr44400139a91.8.1740551504951; Tue, 25 Feb 2025
 22:31:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 14:31:33 +0800
X-Gm-Features: AWEUYZnqLtwn7p8rdsbyWWPnxjSlaXy5DuVDq_eYBndkM_qofe9C8RC5AoEl0-4
Message-ID: <CACGkMEuoaqKB-4rs1QgsEU2rDn5s5GTJaL6jOiFj_TDSF2pC0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] selftests/bpf: move open_tuntap to
 network helpers
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> To test the XDP metadata functionality of the tun driver, it's necessary
> to create a new tap device first. A helper function for this already
> exists in lwt_helpers.h. Move it to the common network helpers header,
> so it can be reused in other tests.
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


