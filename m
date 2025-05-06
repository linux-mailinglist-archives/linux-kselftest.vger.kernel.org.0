Return-Path: <linux-kselftest+bounces-32472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76E1AAB808
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058594653AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2B2C033D;
	Tue,  6 May 2025 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIJalOYb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F4326BE8;
	Tue,  6 May 2025 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746491097; cv=none; b=csYkaNM2Hz7Mkl/5pyxIPh2nT0bzjK4Zpkwd4yyEtyH4+V7byAuDrPpBASXHedSx38rV4zwYVsklI2G/0HOm0lMTHt8fjQo9+nFnwcCMJQqi67euLcdr/jPfqbSxCBdiygRe/JMnmuDlq1QufqB3urD+aZaIb5zdzjfa+uhGmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746491097; c=relaxed/simple;
	bh=alMo7B+Sr/59Du5rvegXFc8Zcs/QVVYNwTJ/hgL1bz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaHD4yvV8wNVCidc8PXh6VuITBFqmA15BJmAUOOVikWlxC6hwv2sK2HMv/MZRWQxiYNXE578iJe33Y/kFlUeBwwRYcrBcqQfrSG6e7ZuejF+5g7sfp8sjaOZld21FMS6VrxcDPMYaBR8/LEQK6qCluDZEmtQsleidF66THToX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIJalOYb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913b539aabso2267308f8f.2;
        Mon, 05 May 2025 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746491092; x=1747095892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alMo7B+Sr/59Du5rvegXFc8Zcs/QVVYNwTJ/hgL1bz8=;
        b=YIJalOYbzRWgk80kCCjkNqfC7uXUYe+sVV24eYXH4eCuTbaLW3Zj55SRfEf6/wFuIw
         HdTYIEUOVs52rEChr8fNimUd8T+K0uIEGFzJ+OSS8jYikOb7bpqHdGXlqGz536b3A1pf
         aQk0yrdaUNyS9XT0sruJkg2ps4jJLEhV+hAUIwuzhEBl5DKRfK2RO2L27s4yUW4ihRbJ
         QDPgcMNToy6aVnEiwg+N+0Ceb+Oh9YhETrPgdumbi8IE+2jC+ildWIpDL0epyevY29Bh
         RQVj5dyVGwfqEc4ybjJNdFlRQDcwCaty9Ue1Fq79BO8jMJt6XTkiEM1FfDZyuB4kM8qC
         jl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746491092; x=1747095892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alMo7B+Sr/59Du5rvegXFc8Zcs/QVVYNwTJ/hgL1bz8=;
        b=sQmiyDWQQNEPVkECMP1FrIBEuvpq2MZBHLc7qKpeNvQ+CZ+MZGb7ahk0BqIoSYZrmi
         zIQrCSe0b0nOGEZdmHfXxkx+y+ZM8jRf2xQdKmu+litw3U8rc6qbZ2wd2Bi1VbVmppvM
         om/nIPJkvxLa+elLIw3wmONStqjddLxyxvVRzOa1zCUrGkr/7IVAgr1IQxymcTVJJH05
         kvfcHqQ61/Vgdad1fdj+R7SXkM1/xXYGl0jCyQPkts4U5KdISn2ImxT8Q2dltLfPDdKi
         /wMODgL/vYefuVesr7GAs1izHDPcB6Gi5sid9wFZ1F1S5+Erfjvx3CF3Rb0qgEJhiACl
         fW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUP/l36bA9+ibx/LrLBGMM4azQnUGPfNFqAK69Uch1p4ZtsKGoPvO0w3sAq1iV5/Tr58ik0nk83rc0d0/o4@vger.kernel.org, AJvYcCVPMLYGNucWvOr/HEnuR1OqxKDQ3I3RgWmXV/83WOb7ksZHmyexSK3VflgBrvOBJJY/sOfJH67rLQtU5ss=@vger.kernel.org, AJvYcCVWHCMrijRj7N0PGthivbT1nRvPT/sHhqVN0/p8Sy9SDaeSDTc4F1zz/tCnZcPaDX6cm6MKwwtud3f+NG9CgdX9@vger.kernel.org, AJvYcCWy5/6b+CD/yTGE+HFqfIL3RbPgkSbCDrDUgOpapPB2RselaafWwtpkS5nUgERA6NTTu6g=@vger.kernel.org, AJvYcCXeY0J1cTHKn7vqHIuf8ywhy3w5izDZKyPCDsADxXLB7QKnhiWKHhBlr8pgi+ytUPwQiwcGA6Kobkwn@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwAo5wume++6Rp8E4d5SpIAyEobwG1Jzl17EVSIdKoKtbZqZz
	JcIhbmvootvMEdkLve+iZPfQAk5NhC1cijwn872bxCnIex21Y2IrDeTvdNFUKjPxmDh4+2Gn0jr
	0oyGMCkCi+715gzetgeWQmZXbGpQ=
X-Gm-Gg: ASbGncseS/Vjsk/ldQqXoaBo2XViaQjmk1o3PkoDpJLWd8qvdUF/umFe7fs2lui9vsv
	ziqJ9MOmS2GoQP423yWGXlSHNV2Z7FsvqsbdxYoHCB7vY+sNYbZR2fFdIx3Ig7x98FgOl+6AO+s
	qQa2NFtX7aCjxSK0M/SbPYB0LP+997ini8YwUFkgBPi2T1iJclEQ==
X-Google-Smtp-Source: AGHT+IFpisAarDVCqmL4SQ9gwYM4+gMG4oHDBZFnZvyt5pgd5IHINbs0VFd1mFStWTTZZvgPPgIuW+AiPJw4Ajhtqw8=
X-Received: by 2002:a05:6000:2289:b0:391:4095:49b7 with SMTP id
 ffacd0b85a97d-3a09fd89e32mr6735387f8f.25.1746491091758; Mon, 05 May 2025
 17:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504224149.1033867-1-tjmercier@google.com>
 <20250504224149.1033867-3-tjmercier@google.com> <26ca8ddf-0d78-462f-a47d-a1128b2e058f@amd.com>
 <CABdmKX2iNk22h-KxUr4yvZO80yeRRjMfoC7yjiZ-aR_f1k402g@mail.gmail.com>
 <ec43f447-095e-4baf-8610-8279b565f162@amd.com> <CABdmKX2Tpv8vpDDZ+wcdrWuijfC1wkNhJQxVSC9trPkzBLN4tA@mail.gmail.com>
In-Reply-To: <CABdmKX2Tpv8vpDDZ+wcdrWuijfC1wkNhJQxVSC9trPkzBLN4tA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 17:24:40 -0700
X-Gm-Features: ATxdqUHDB7Y3bq86ORp3ezfiMZIn0_EShKe0qk7UMyPGPboNnGF9l2fKY3gc3nw
Message-ID: <CAADnVQLqv-ZpoQEhk2UwvSZorSLcjgF7qLD76oHguH5-GcSXxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, android-mm@google.com, simona@ffwll.ch, 
	Jonathan Corbet <corbet@lwn.net>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:08=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
>
> Sounds good, will do. Thanks.

looks like the majority of the code will be touching various bpf bits,
so let's route the first 5 patches via bpf-next.
When you respin, please mention [PATCH bpf-next] in the subject,
so that CI can pick it up.

