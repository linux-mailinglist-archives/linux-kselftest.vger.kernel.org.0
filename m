Return-Path: <linux-kselftest+bounces-29053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4CA614C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084173B6C41
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC720125F;
	Fri, 14 Mar 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP7CaNgk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475A1A83F8;
	Fri, 14 Mar 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965793; cv=none; b=klda1wqACrD1v1N7QjTZbmJ7cDe6C9XymlATk/5tJDnkz2d9paQLa72EiOMoegD381xbLu7fW46952iAKQvk3AValAMNa05kq8NcEiH1P10XMQOTrXTNdMTdrDVGmeXhpQFcZPmAdAsJfduMNw93d3wcvBtwfwSnKtbm5V8r3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965793; c=relaxed/simple;
	bh=onGdMGQ9h5riy+xCuuIEp+wSTHDIPrfRuS2Z7rje+4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNKrizyjjPgz6E5RIcqMIoUorT/3FLt6gk6oLpFySgfnUFSedPS+j/3bc6uNTyBG7Wpb0zFHhZOaj7xPAJwyySFAPPcrbn0kjAvl3mPdeWY/U0beUU1VzUkJZHuwW70/5RhW1bNMZMFh8uAB1ittztT78uTZDzCoeALOp8t1OsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP7CaNgk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso476856a91.3;
        Fri, 14 Mar 2025 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965791; x=1742570591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onGdMGQ9h5riy+xCuuIEp+wSTHDIPrfRuS2Z7rje+4s=;
        b=ZP7CaNgkXlB94UHy8o/fwyYaGZ6hXTn75sxImS8eY/8CuIjEIkJFYPSgc3+5jE2uxb
         jwitLA2cVVfDfxH5gqeU8bBaD9HYQ/kJGe3ihbi/kAdmV1lcsh0cUU7lbYM3AVBn0AXt
         ra8Hinm0UpVucQuRADkcSK6iWTVUdZoLJjhOeGxKJ4c6anL8+DYVNbLro3tXUUpELpnd
         ujbSusj4M8U33SKeuzrtqj8EqjsFIwE7wCa4xIRYQ5ZIt/VEaAh215u1lQdQVVolTgRw
         XgSqZihXSPOBHNWkB7FjAVeMd9je/QFEjY3314JaeKejjvp0PfccCXbIMUgNHfwZ7+fe
         4v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965791; x=1742570591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onGdMGQ9h5riy+xCuuIEp+wSTHDIPrfRuS2Z7rje+4s=;
        b=XdcvX7djNxeE6/fv5JJ2PV22Hn+Q/b9BBxdrYIHla3Zwhu6J3+42ChrD94mhLudRM5
         BhPKevm+MPy2KSBGdIxQyf71UyOPf3DTkzkgUjcf+HQjI5Hizes+1znk8HN6XWRSA3kJ
         K2N6n6i/9wLZESS6qNFdAneWU7yL7Bb0z2mE7/XAEOk2s3nK6CX6RSTB5hD7Hiy5A9s0
         cplk4RMdbSCdhWabNBFxXopZKvM72jkcfA65K9NCUnjcefeDqEAeTr2EQbqUTAEA1nGQ
         /j0iLdqZUaXCMemlDZppRikc3oQs0YayUjmYyIhWmW1DGO7YHUHS8hPKJb02NWfAyD/u
         KVyA==
X-Forwarded-Encrypted: i=1; AJvYcCU4s4edLU6Q95dp7BiYznbOwvgtB1q1AJ6EG5ZKiwtQF1uz4mUaf0YDgYCu6GkAsmPzEb91G8CwuPFqIMXM@vger.kernel.org, AJvYcCVxX+QNczOFRaZUkq679HYoalYWVAJzV/AUVLWuzQ/V7Kb+1JJWVd1TmJl4zXNAFEZLFonJYWSb8zjIeWZd5FY=@vger.kernel.org, AJvYcCWAACtGtWJOIzWeVfa4lI8gu1WTwie88CXVwYS9dPghZjmsgnU7rpr2aWkHU/eCuFBLIg8CMZ5FFtwuUq++86zQ@vger.kernel.org, AJvYcCWGN3uCY2SLSSZ3fZUS3jFSJzTHh4Hn6m3Yp0np7pN2BCOSo55M03s1foedyfXnZOfds/U02tY7NKbkBeY=@vger.kernel.org, AJvYcCWsO1/H6BTSnun5SfwDYHVefZtOA4oIWJv1g61B6jz17rZBD+8dGwGb3bIacchSxuVBROizOv78KSjx@vger.kernel.org
X-Gm-Message-State: AOJu0YxC57NrrdxSA2dDlVo9v5D72d6rVQQ7lzUXo3WV+cu7N0V4gBgA
	cPsXcCZJZBRn+ryr4Xfl1nuUB2eEtiDH3PMTIXcf3hZ2rIlDGsQ3Qeyd51h6hTG8DqerielRrW5
	eTHeizDD5SjVUqtB5bHmJj5Yg+lk=
X-Gm-Gg: ASbGncse2cupqWzHGP7Lkrye/PqmHw03N7MwSeHq/IZmLpgqZgLLaB58g4Xfpd5kV26
	8G2LEstJr23hTPi7dL4tRYH9c1Da9PGVHtnk4yellpJazhb6Ra3uXMQdo3yffWG+zXscGzha3Z8
	DN8g0wWxqS8vKHIZNnevx43qPGNg==
X-Google-Smtp-Source: AGHT+IGXZ+sIMicF7ioYPohSk+0+pI5Y4ZkfdkmKCGHLNPxqRGWFte3NiYQ4N/30XfwYHbA7fFBeZ/NTmqaBLnciMp8=
X-Received: by 2002:a17:90b:38ce:b0:2ff:6666:529d with SMTP id
 98e67ed59e1d1-30151d6e1demr1481405a91.6.1741965791659; Fri, 14 Mar 2025
 08:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
 <202503120332.YTCpFEvv-lkp@intel.com> <CAJ-ks9mkbs9KG5D5yETvOJfeqyzTts1gVZyNAogbxjXbwOreZg@mail.gmail.com>
 <CANiq72n2cYvAWkz+QwG9++NknaN-A2g=N4AeatADwRZ1pWtk0A@mail.gmail.com> <Z9Ipko8DBD2cz1nF@rli9-mobl>
In-Reply-To: <Z9Ipko8DBD2cz1nF@rli9-mobl>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Mar 2025 16:22:59 +0100
X-Gm-Features: AQ5f1JqAXlG0OSn1ajgmyqsScjagQVuSo381KPk2FBlBxX6zol4hwhDWmTs8x3M
Message-ID: <CANiq72k8kXeK6C=yh9-LNXbeF=pQitd-7sVP7AsGLBHATfEF7Q@mail.gmail.com>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
To: Philip Li <philip.li@intel.com>
Cc: Tamir Duberstein <tamird@gmail.com>, kernel test robot <lkp@intel.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 1:41=E2=80=AFAM Philip Li <philip.li@intel.com> wro=
te:
>
> Sorry about this, I will implement this to make it clear asap.

The bot is great -- thanks for all the resources you have put so far into i=
t :)

Cheers,
Miguel

