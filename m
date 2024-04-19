Return-Path: <linux-kselftest+bounces-8399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 427568AA830
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364E31C20E0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C929C121;
	Fri, 19 Apr 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7adLZnY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DF883D;
	Fri, 19 Apr 2024 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506715; cv=none; b=ZVxw8lD3eJq0Sf2UIX4010TQCwaAcFTPsJGG3VhSlHhTg11aGjTG2iwxBn5ml4f3GhX0mu/gQNhWo5yNaMbSsda6LWHOrTrO2VlP+SSadRh7pcxeqfOoMZYb7g4MsGhzJ+Eys06k50T4d06DRoB5+DzKTN1m/QtjSBwH7FI/E44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506715; c=relaxed/simple;
	bh=Xs4qN48j4cQd3Py06qFO9cZzzc7akLDHwk4EwSAaGw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCiKBJ45nFm9i6tKDdHf7EGlqcUlq5zqe6WRFp50HihOx/pzIMVPV2mjgaSMx1TQ0t1w9qZAQL2gxjWaCflZjOfBhR3VpPLIIkPgt2RizWuZvRXOHHo513gbAALW9Ikcx/HLExl7U3FNp7Ftd5CqJ6pPtbLaE3ilBXqkOiT6+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7adLZnY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso10000675ad.1;
        Thu, 18 Apr 2024 23:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713506713; x=1714111513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8omKplIPAi499atqXdwcLykhK2vn2gCUsgEUak78Ic=;
        b=J7adLZnYiivT3B3v++PaihU0adXmUVwi4dyHLHCgnrExiriMFcz0ulr2RwgqLg2p0n
         8iX3fApuGd3o7KTViL3IMN4gbv4RuajMrw80yvOCzUjuXvRUpO5rybmYSM4qAcPzfOYM
         AZaMXcswldTVP2QkvNw8C48BNgeh9eoFhIB2AB/3VNhZGMa/73DrzCGuZpKs2r1LflU+
         6+ncnip08KtM5bGGOBm0VJ/NvKPHeYa3Lw/jft6LMPCh6f3aceWnJIriaC70ZF04V+vl
         wMx04bSJo0AcaX7K/2XRNpHZ1+z+hQYAf1U0qxTrTj6tlT8PrnBVF1g9GIAA1d/Pz4qn
         8heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506713; x=1714111513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8omKplIPAi499atqXdwcLykhK2vn2gCUsgEUak78Ic=;
        b=Ey8X+QEQtPXBiPBjbQA3eDQpHDVIiwltVN9XKllaAs5/HrziL6HM/Cv2yD5kaftz3d
         GGIt76eR+D8escVfcMEYDloKUiABX5O51ET6V/eF0opLt8wnYnSA2d05nZLzyTRoPpJ5
         MN3PQLKJrJs3H2ddrSAkcYwR+NTlbjxDRTy6Gz4Ms3Lk+bsYkvcLYCrAGsv0/OnJGuQe
         67e6BCOQEEO1lr5nTbnADXaiIEcTDCzawBgTxUTK1eqcKaZrv1QmFQtFQV486ICwLPgh
         zeutVxDr3inqeZBi85SafrvO94nf+hJCObDeVTtz6J3gWQc0rZNqp5dh6Q/UynPk0Lia
         TucQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwtxbzHbAveOh5FO4y8Bpt1ppuOdU8hqYxidaXDfoKJ7W9buPbcV9XU62hpvnWVUICQJR0bg9V5bEInSQSTcMHCgVQ7+1rGRbVNskkpOHNtjUjAbINXtPQAbMq9QtlGODeF+BxrfLeiImE/Fb6Qsiz/NdXBE62FnXBgTNT5H/8WIwA
X-Gm-Message-State: AOJu0YwmDCeMrwDlAMJbMeSSFpSywvlEhBE6l3d7+xXp3j7DrUYAGqG7
	vpKtj+V1oNQt1XMhImTwRY9mMDnM7llf3SpQ5ZwCne+4QnzXIug1dTPXCQ==
X-Google-Smtp-Source: AGHT+IFIfVBfVza+5cuWpXb6ItwjPh2irMimhA5vYrc6K6X0+e0Mmr8f3XZMvdKNkb+BsERhPo0GeA==
X-Received: by 2002:a17:903:11c9:b0:1e1:214:1b7d with SMTP id q9-20020a17090311c900b001e102141b7dmr1140762plh.61.1713506712987;
        Thu, 18 Apr 2024 23:05:12 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:fbcc])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b001e61d87e4aasm2529638plf.185.2024.04.18.23.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:05:12 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:05:09 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 09/18] bpf: allow struct bpf_wq to be embedded
 in arraymaps and hashmaps
Message-ID: <4y3abjilpoamebie7gmgn7cvs2s6m2eq3asd3huuw2xenx5fgp@lwyzs3ghxevp>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-9-c9e66092f842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-bpf_wq-v1-9-c9e66092f842@kernel.org>

On Tue, Apr 16, 2024 at 04:08:22PM +0200, Benjamin Tissoires wrote:
>  			WRITE_ONCE(*(u64 *)field_ptr, 0);
> @@ -1119,6 +1127,8 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>  				}
>  				break;
>  			case BPF_TIMER:
> +				fallthrough;
> +			case BPF_WORKQUEUE:

fallthrough is unnecessary when cases are back to back.

