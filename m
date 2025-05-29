Return-Path: <linux-kselftest+bounces-33999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D2AC7EA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6093A9890
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815B225A32;
	Thu, 29 May 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRqL0uu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E3647;
	Thu, 29 May 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524917; cv=none; b=hCGrAVQaZDhPcXwBnmqq4tVCDfqG1YvgElUC0exJr7Nzc8IKZK/NWioNeFgU43azKy/zjV5txTS49vEJ8fscF7lsJiUiNQauQv6SIcjYd85D7VWRxn9ZRNgiNjEhTy7aCZJH+CsJrb81mzYaxDo2xjNIF8NdByrIE6f6lV8TLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524917; c=relaxed/simple;
	bh=SN6Mu4JxvkIGTbp2VoyF8l025poz7YYnqBe3byiyb+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaCYG+09J4SvWK+UVkDAtDbb3c8o5/YECdVKamyp9jO9MepRt4B51tVZGgv7ZKnGuvHI2DXs3aqtalfLW7+188gS3ilXy1RYzOFznhDXxowMl/pHVemyxAUj8hX9zw/4GL+iVrVSEsyQLmHAQwm2GG2DmoLp6eNeOksQSRT77b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRqL0uu5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2322d8316f6so1064625ad.3;
        Thu, 29 May 2025 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748524916; x=1749129716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN6Mu4JxvkIGTbp2VoyF8l025poz7YYnqBe3byiyb+Q=;
        b=SRqL0uu5UAiK7emC6cU3gG1kTyFmeDOAkog3G7bqgiWZf3nymoSkgD7fD8nRNZTkAv
         KPzkKSzvzfk9rRZdcPoiNxjvFRIhgSMlmDj7+Nf91xDbXqPY1ywZMi8utd66xU16Ozah
         mT142MNJG22R8on6sKbWBk5doSWXfy/mCOFdz8OFGuY+lloLXLxGuqLhtzUTj1hPCi/b
         3dDQCmtDu2vDw5wqOWgVMjgdpLkBigmM42FDRCDoN+hZ9oW6YAjrlZNpMbJaq73phttb
         VjdG3Nqs9sU17OMOhT2SYrH7TKbGvKtcBylBS8dAKMeqgxShhbIMKm9z+NloLwHuNDeT
         GNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748524916; x=1749129716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SN6Mu4JxvkIGTbp2VoyF8l025poz7YYnqBe3byiyb+Q=;
        b=HlPcarBHtDOouMWnTud4raUml0o2y05DIrTH2bgEqPeQzAg7L7mW4fSbFfBCYunv6F
         LXYFt56KEzOx6t4p3+l+cp5ax60Q71F0rIYFKZnpIK7riQj3+F3fHFB2KqK7pQFLzAg8
         GjVmVFpzvLMyY/6FxLkHDm8a2q4810qvtq3IYGAGcZgErLQtsKGHQTdE6Y6zY2vNPbo5
         LyzuM+ovFxznddiyv3uog32xl5v0MFSaD+QjyqpUJ7dcQI/W05p7wSP14NvvdOf71dlS
         vW7lSOmE9BpVgLLA+oUfwSnGdndzBkqG7o0b/M2CN1PClBmcDD3yALrAB9dBviNqy9cV
         mbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8mjN0P4R1HOw9J/MzA1O/ecbeNcpKguYzN4pj0n9saP6/46jBaIYqUjus9arhJT0/EKcY+NlElLNiWn+Vj7Wv@vger.kernel.org, AJvYcCUawHqA8nBZ/g0lw90QYbTGNAc7Q5b5XDzzp+d9ovgpmjhZO7IPmJ9Rs0TjDanj7+aqMeUuVtp/ZNFB/sc=@vger.kernel.org, AJvYcCX37SLC84ahPhqiP6jgPqqHzDUFoTU7vH+USxBmmWoZcMYMolCReb/5qkwnF9AXP47zJWRQwCwChjMFqpVT8gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oM3xycSzTmma30bGyXgic90dsG2bFJb3pzcYYNSPVwxwAU5T
	8GXz8t/boDBgrbDFzA9B/SRHMXgdhE3KDVAgQSn/WRZOKufl8S8NkKwEqY+m+ClORNUCL4oiI5z
	LSMZklEFWpX3MroLesj2f0DOkUW0deFc=
X-Gm-Gg: ASbGncvmLsY5/IJOVyGCyh2ga3Y2PqtyzlNeFb/Iby01saqmgbkRj7vxRZUfz9e+2L8
	JYeI2TGbU01qAsXn7p8xxf+htBh82FzgKN8iYFPN5z7FWfmPbkvlxGwXWd3lH/kZUYV37jfO3zr
	dpQ46FaUdnpBtvh94JQu5E/fitIaI+7pchFB7Ke82yMWc=
X-Google-Smtp-Source: AGHT+IEw3IfjRiVmB9B6f5XuML+7UkncMFZmzabzcloIvrow/Wn2iV4+leCCTt22pE+x9RCQAjX6Ih6PN46tqK1oGuI=
X-Received: by 2002:a17:902:c407:b0:235:737:7a8 with SMTP id
 d9443c01a7336-23507370992mr13730985ad.3.1748524915877; Thu, 29 May 2025
 06:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com> <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com>
In-Reply-To: <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 May 2025 15:21:43 +0200
X-Gm-Features: AX0GCFuco26rV0hLqSzHou5ShkVizO8CV01DHgm65dtjBe0oghAxdH5dFDdhRcA
Message-ID: <CANiq72nigDV2R_9PNOv98nGBxDZ=46WcRM7V05nQWni5VQRw6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: emit path candidates in panic message
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 3:15=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Include all information in the panic message rather than emit fragments
> to stderr.

Could we explain the "why" as well in the message? (i.e. not just the "what=
")

Thanks!

Cheers,
Miguel

