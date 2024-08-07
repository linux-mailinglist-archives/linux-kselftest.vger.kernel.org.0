Return-Path: <linux-kselftest+bounces-14977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C994B23A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F305B2198D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBE14F9FD;
	Wed,  7 Aug 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcRL2ecq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F941487D5
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066490; cv=none; b=TquZqckRpemT/EYZOXOOqIUqvW81DdVbWe2CuedNAfwqy31rjc72EXlJ9j03liLrdAufqLS2p8x42SUHSICsa00P4x21nSBk7G/kxznbFMRYHgc04svzrUatOlky/1wS7Q9v7GjXIL01uuFC/uF77bSZyNO34ahYIWPmVYBiUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066490; c=relaxed/simple;
	bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF+2XLdJSFHyzzW94Dx/VIKa6BhAk2LyJsEzqLuAhDJ7vvFm0/rov5fD5mYiT9yhj83xf9QH64oChLcCpwIjZZEnJH4mxbnAywrMFb/UtWddr01OwIh6U1p9XH1RuUXNSho48X9tB+CLC/QeIueV9aUHvIZskFr6JpmyX5earFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mcRL2ecq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2689e7a941fso264202fac.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723066488; x=1723671288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
        b=mcRL2ecq0/dMdPe3hEsVX7V6M5CgVFjU8cSQNOg8q0N4Ha/5rLaIFr3dw42g0QRa0N
         RTBhG6681NRFKpeF32jzoo+qiEUi7CWCGwCkTwIoo+/xbVM2/OZFd4WRYqozPWHwr+S2
         Oao5Zu03Z3fHHaJXM28134rS3lrayL8It7k1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066488; x=1723671288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
        b=oTn6Nxxd+h5qEIhZF7s5dhiMO78/LmRl8ISL1+UIC37ncU3CjN9jcR9i1xXalpmpt2
         ABWwV19VOa+aY0sVQNo8GtZ1ylDciBRe7c7rfxOPAJGjXqaNa8QSAPI0mqG2ECg+/vXF
         1cnn2Z1MVXo8SkC5si+tSpMXqM19UustHTrA3w3bi3kOv9nA+GzWTGSNKWOH0X08exGQ
         nYpKGIMi6tCKXN/18pIsazhUEQah2Gf1WjKV6pePgGblg+rQ1/JDhCwbgkzFUkhu94Rz
         orMseN/Vhdmt2yJRPiPFVjiIX2ebJ3V+j7qiZb4wPaYL7oBTRMuOwVLvnNPfLqoT0wy0
         +mjg==
X-Forwarded-Encrypted: i=1; AJvYcCVaob7waz2rzg7TxtQzYPvGPc7tbFC0k6YIiQMBh8idotpABPqmS4Q/LHydTNZ08I0AazKFKqeBsYI8cml8n1opTXYj6akk4T0nw0WzqVvW
X-Gm-Message-State: AOJu0YwqMDnOFbGyngkcSZi9HJ8j13OqdlTlxjxuOcypk1PW0FVnPiP7
	darhH8iefA07prxpcBGZ+H806lduljBVBIF39G4WaCpUzSMFqb1O09EIPMNXj719pwUQOQitAEt
	rfACc++v5ZX1AN8uACo2S7CqjqnGl/pieo6gty9hxcVX1IfwioHiR
X-Google-Smtp-Source: AGHT+IG5ES7X4tgKDJv9g84tk9ALZ7Sp67s0jLTzG1Iz9nJGWu6UaYHks+HxXA4YIPNwg8kjSy39pOHEV1+hFz8rf/M=
X-Received: by 2002:a05:6870:3051:b0:25e:b732:a913 with SMTP id
 586e51a60fabf-2689175a388mr24548521fac.0.1723066488042; Wed, 07 Aug 2024
 14:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org> <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
 <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com> <CAKbZUD0JuEwfd2VnY_Kbv2Mr0g0KN2T2mYCLhPuS8j6PhbCNiQ@mail.gmail.com>
In-Reply-To: <CAKbZUD0JuEwfd2VnY_Kbv2Mr0g0KN2T2mYCLhPuS8j6PhbCNiQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 7 Aug 2024 14:34:36 -0700
Message-ID: <CABi2SkVX7nFwPDAQaYWn2Y33OnJRs8NJQv0oW-QJUcSYB8a6tQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:20=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 7:03=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
> > Do you have any suggestions here ? I can think of two options to choose=
 from:
> >
> > 1> use 0xd0000000
> > 2> allocate a memory then free it, reuse the ptr.
>
> Personally I'd prefer 2, if you really want to keep the test. It's
> also a strategy used elsewhere (e.g mremap_dontunmap.c).
>
V2 is sent with 2.
Thanks for reporting this.

-Jeff

