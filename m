Return-Path: <linux-kselftest+bounces-32639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830DAAF0FD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 04:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300AC9C6B95
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 02:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095719E826;
	Thu,  8 May 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPtszyIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF78C0E;
	Thu,  8 May 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670135; cv=none; b=Hz+j6+kccKgolB3HlkA/gFM7IZTOiWYiqjwgXaC+qr2M2XCD+soj3Zax6hIy2/6gUoLGs+7E4ZcHz2hW6m3ieBQxYiedFBdv4LCKHrB+2cw8nhSyEXRYz23sSJNlM/tUr+u4+rnmRbtKarY0fVZjcHmFugezox5yIkb4Te7kTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670135; c=relaxed/simple;
	bh=dLs5zRkSxw947DPEVhEALcB1cBdOeCpK5me8+HGfXT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLcfTrXNis0p86HTRv1OFe6BGQb0jU78iUss8y/YX66gxXQItusZolQX5Y1+XhjHFXZ97l3u/1k/drGIv9f9tZgdlGNYU3CzhZ6xgMWkcgmyCpO2Jwp13TB5CtJXCk/ShmbJkfkpNzqBhPkYcO10EYoCgV8NhF5Pq9rsCzIqVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPtszyIH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73c17c770a7so633227b3a.2;
        Wed, 07 May 2025 19:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746670133; x=1747274933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHNvw92XYRZPUd0bYHJyEHW/Md8K5EFmOKRKZwWuqDk=;
        b=WPtszyIHeAkHhVBI2/8I3EZWdQFSNn4qmnWPvfAnjcS33GHEH3SHf2MbNgHzBYNG0Z
         AYRXVIpNjGTQoTuYL+XbhTqkUxtQe/x6F3dItvNJcoDHzOBP7dfUt8CcETdPM4+de6Dz
         s7ozt0H85ZtgveajAyPxv3Cc2a21Fzlor9SrXG3WGlJn90Ftf4Z/r5tzXvbWf+qNEII3
         sEqFKS4kt7sZmC8Yapc+jZg8yTWuyNPMA6n06mPxS0p6HbUNdgP9ew1RDx9tBZVfLu+x
         JrI1xVwd+z0inozL27qV8C3B+cfKcinVEbynudMrBWDH2tKNDJAtXTmhfWa0bvmnk8cA
         kkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746670133; x=1747274933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHNvw92XYRZPUd0bYHJyEHW/Md8K5EFmOKRKZwWuqDk=;
        b=K1NiHi+riL5Lae4cPzoO01VpZxUweOtmc3A6cWoDTWgv9Ckq5ZiPVYbROkXQU6X+gf
         /3kfpACL+4nuEWbdftJqOUAXPi5T4tU0gYnT+kur0EQ7gEBXJOjEZ6B5xnCKEKl/qfSR
         HVcUS7vBIfpiVwimXgCrhMsPTQOqQDGtusSdtZPmzD5XR5d3dT5O5yRbnzYztP/OX/YY
         xHfVvdap+qNgAH2Tk6ATujV5UJb3tQGqpVADZvSwMgDQ9RsGI+nH4lqS2AJfYVoYC0ca
         bRJ/WqBbp0X5QOopNMBPR1e+rNu5r8MF2p5RJKVa4aBwKfjb3/vTjeyHWLEnA/L6cOMe
         3eTw==
X-Forwarded-Encrypted: i=1; AJvYcCUBWsCzL9RnrtSsW2+7IUokRrz1FoKhEQWdyX4gNF8VVUE0+FQ7aDoABk5WaBv8mBA377O0eWTTv1g=@vger.kernel.org, AJvYcCVAaEW2COVvULvBdEdALAD0usmq/qg+N3EZQVXBl3M4FDalSAcIF7Sy/eg7m+5uNZAsi7+U/1RGw805k/r9yPLP@vger.kernel.org, AJvYcCWqGOh/VBH3CwkowXefcQc8M2OltsxUPQ6XCf6UURyEBgM8CdX1oEt7iNXrg43SxXMV9WjfG2wqRTPFvcdh@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEJNxBEvSxbCIglyNdt2hEOoFGXaMB4Z0rw7qi7jM29aLkfYu
	F0iZJQFZiQkUGEj46kyglAcInyl1onrhux57VW7h+2YF5ZrfXsvP
X-Gm-Gg: ASbGnctQp117AJuhmcyAO+o5v/KqVeCmuy9iMAwUIFgl0GD37G2z988lvE7jUMNB8bP
	GXDoZcN0FKOOXsYceTYGIm6skeucxuHDBdl1UR4GUWKGIM5odM/k5y9mlheIK93TZWJm/zKSVzM
	EKWNMBydhuiUL021os+8AL13QWoOm4jhMtUY/qa4Ib4b140jKq34KtC41Fi52FhC8HfQ8DRqzsH
	aogVfLl6KPJOIqi/nd3BSkfVuBJEKehqqLbH7cym6TVvF88IrRjf3EjgujIWr2bAZAtz9ummgrX
	1+KR+ssoUfYlS7dh9r0xPbJxfbmsLSIflPS2DBkK
X-Google-Smtp-Source: AGHT+IHyYIyMS+wJOwvbZyE0lsRkB8xUwys37y10aXOMDjyVWuq4/1AmI36wrgPNKy15UXdo6BiBCA==
X-Received: by 2002:a05:6a00:4c09:b0:737:6e1f:29da with SMTP id d2e1a72fcca58-740a9a71fc3mr2200262b3a.21.1746670132634;
        Wed, 07 May 2025 19:08:52 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dfdsm12047215b3a.119.2025.05.07.19.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 19:08:51 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7B4A941E8D47; Thu, 08 May 2025 09:08:49 +0700 (WIB)
Date: Thu, 8 May 2025 09:08:49 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 8/8] Documentation: ublk: document UBLK_F_RR_TAGS
Message-ID: <aBwSMWYnh1zWgSjK@archie.me>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-8-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rg2BuDlVNkC7GlP/"
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-8-a2a298783c01@purestorage.com>


--rg2BuDlVNkC7GlP/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 03:49:42PM -0600, Uday Shankar wrote:
> +Load balancing
> +--------------
> +
> +A simple approach to designing a ublk server might involve selecting a
> +number of I/O handler threads N, creating devices with N queues, and
> +pairing up I/O handler threads with queues, so that each thread gets a
> +unique qid, and it issues ``FETCH_REQ``s against all tags for that qid.
                             ``FETCH_REQ``\s (escape s)
> +Indeed, before the introduction of the ``UBLK_F_RR_TAGS`` feature, this
> +was essentially the only option (*)

Use reST footnotes syntax, i.e.:

---- >8 ----
diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 440b63be4ea8b6..b1d29fceff4e80 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -325,7 +325,7 @@ number of I/O handler threads N, creating devices with =
N queues, and
 pairing up I/O handler threads with queues, so that each thread gets a
 unique qid, and it issues ``FETCH_REQ``\s against all tags for that qid.
 Indeed, before the introduction of the ``UBLK_F_RR_TAGS`` feature, this
-was essentially the only option (*)
+was essentially the only option [#]_

 This approach can run into performance issues under imbalanced load.
 This architecture taken together with the `blk-mq architecture
@@ -368,8 +368,8 @@ With this setup, I/O submitted on a CPU which maps to q=
ueue 0 will be
 balanced across all threads instead of all landing on the same thread.
 Thus, a potential bottleneck is avoided.

-(*) technically, one I/O handling thread could service multiple queues
-if it wanted to, but that doesn't help with imbalanced load
+.. [#] Technically, one I/O handling thread could service multiple queues
+       if it wanted to, but that doesn't help with imbalanced load

 Zero copy
 ---------

> +
> +This approach can run into performance issues under imbalanced load.
> +This architecture taken together with the `blk-mq architecture
> +<https://docs.kernel.org/block/blk-mq.html>`_ implies that there is a
This architecture, taken together with the
:doc:`blk-mq architecture </block/blk-mq>`, implies that ...
> +fixed mapping from I/O submission CPU to the ublk server thread that
> +handles it. If the workload is CPU-bottlenecked, only allowing one ublk
> +server thread to handle all the I/O generated from a single CPU can
> +limit peak bandwidth.
> +
> <snipped>...
> +With these changes, a ublk server can balance load as follows:
> +
> +- create the device with ``UBLK_F_RR_TAGS`` set in
> +  ``ublksrv_ctrl_dev_info::flags`` when issuing the ``ADD_DEV`` command
> +- issue ``FETCH_REQ``s from ublk server threads to (qid,tag) pairs in
> +  a round-robin manner. For example, for a device configured with
> +  ``nr_hw_queues=3D2`` and ``queue_depth=3D4``, and a ublk server having=
 4
> +  I/O handling threads, ``FETCH_REQ``s could be issued as follows, where
> +  each entry in the table is the pair (``ublksrv_io_cmd::q_id``,
> +  ``ublksrv_io_cmd::tag``) in the payload of the ``FETCH_REQ``.

s/``FETCH_REQ``/``FETCH_REQ``\s/ (escape s after FETCH_REQ).

> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
> +  thread 0 thread 1 thread 2 thread 3
> +  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
> +  (0, 0)   (0, 1)   (0, 2)   (0, 3)
> +  (1, 3)   (1, 0)   (1, 1)   (1, 2)

Add table border in the bottom, i.e.:

---- >8 ----
diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index e9cbabdd69c553..dc6fdfedba9ab4 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -362,6 +362,7 @@ With these changes, a ublk server can balance load as f=
ollows:
   =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D
   (0, 0)   (0, 1)   (0, 2)   (0, 3)
   (1, 3)   (1, 0)   (1, 1)   (1, 2)
+  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D

 With this setup, I/O submitted on a CPU which maps to queue 0 will be
 balanced across all threads instead of all landing on the same thread.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rg2BuDlVNkC7GlP/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBwSLAAKCRD2uYlJVVFO
o8UNAP9TgXY+vE6qRAR9fejHqskz0G+yEp7Vh1iKjQ4bgFEbqAEA/zXNe5QD6QeT
g214Z1n7ONm2AqN+10jr5nYqvSlUiAs=
=BlQj
-----END PGP SIGNATURE-----

--rg2BuDlVNkC7GlP/--

