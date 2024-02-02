Return-Path: <linux-kselftest+bounces-4055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EA847D27
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FD81C21710
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1612C810;
	Fri,  2 Feb 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O8S1cgsx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169A12C7E5
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917002; cv=none; b=dEGOZ5Fzpe8GPYqlhevrvlc74C84LnlIqREZT4+FUJKS0xAqHD3chwtdZGvy24pCaxwk7O1YlwB44NdhSAxzvSb54KXLjf+Zy9yGsDgIdMh76t7myjVzMycCEC7kJDczCmYpuZHNfoR+IVUnjrWcYdSxAJgY8igoLK0fah47qXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917002; c=relaxed/simple;
	bh=V9SNWHDZPQxXdnt+QLityMKsnJ5V5efabUBxNJBV1ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OSp4AsSdRmDSwOcILOahVfSlwuI8H+A8Nm/u7w1pbiqkKd+DHcex4OzJ1qsvMOEM2g2ikIMVLpLPnk/sa/U7bd1PdnHZkC+JSv/stFiFlORiHiq82UTOHQ+/DXwSmErfOu9puiguBXjs90AmSR0LFMl3NX8vTLGzwCW3SFWijcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O8S1cgsx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5113ab4ef05so919893e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 15:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706916998; x=1707521798; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SRMNOsCcbrOqX9adwJsQYa/MyESMyF05yAtCSmgC7c=;
        b=O8S1cgsxsBPvvxZ7FJlY3YwNiHxdVl+Zo+VnkNY067gVDtZmZhk+JiK+ZmkL2DhndQ
         A7xWyYzkENb8qGLQ0C7B2sLB30I1RqegTHrLN/UO7p1DpsSe8/nk50wHLCpacPeDZ2pt
         tA/fTTc3IS6StYRAPFBGanUwbutCIgmvpK3n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706916998; x=1707521798;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SRMNOsCcbrOqX9adwJsQYa/MyESMyF05yAtCSmgC7c=;
        b=W3gDCnWn/gJIjIxIu/iAdwzqnc2DGvIORIwzHqf5VvPbrfzb/S82j5eisz3u4i6Bdt
         ajJwgPZUrWJwJoRsK+dp+YmAu9JIFO1Vqyz7BTSyLcaeVG2gxcE+JJxelTj+a8flxErc
         /T3E15GevQPINHcMhi3Jr12xQyjVYhmDFxFM0Qs1WpLxYMqPvVEMAGATcE0NUq2cvY+k
         eUcx37LQGN6Aa75+yY+FRTfxLpWL3eEretiYTI38GcXhy72hT1lNm2K9GUe0pz0bDJIz
         o1oDUTfE9t7P2AQjWh+bAwAv+ghR8JWGcnuZZ8EOWXLA5VvxWNi4YdOhHch3qOzvMzxQ
         XKng==
X-Gm-Message-State: AOJu0Yzpsba6Mkbib6CB4nz+z/cShVMCJqOkc21CCbvTaH5xhblXvpjw
	FPpbjpsiTEWfNnonGwc0jQnlKcsVRIx7HH+5Ic0C9w6zlKoTufbBLREu/92othXw5Xna6gw6tWy
	6GmkyvA==
X-Google-Smtp-Source: AGHT+IGbu8b1JcLpNEjuQ/L2YjeStTpJlWN5eHGjVrS4Rc5MpcjO77gH6T8YDjl4iGsRQYo+LuZFNQ==
X-Received: by 2002:ac2:5393:0:b0:511:324e:3e8c with SMTP id g19-20020ac25393000000b00511324e3e8cmr3086253lfh.50.1706916998124;
        Fri, 02 Feb 2024 15:36:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkrTJDYBhymhvU4wPQwETnVbxqeaz7OH0OuotLKACkFdstHtKpnix4TweHB/rIN9pXHOuyRyG1eVaOToYSp15pE7AUPm+yFMI3y2TEb+WM
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d27-20020ac2545b000000b005101f0171d7sm129855lfn.298.2024.02.02.15.36.36
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 15:36:36 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51138ecc651so1524694e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 15:36:36 -0800 (PST)
X-Received: by 2002:a2e:8902:0:b0:2cf:5247:23cb with SMTP id
 d2-20020a2e8902000000b002cf524723cbmr4207675lji.39.1706916996415; Fri, 02 Feb
 2024 15:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org>
 <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com> <20240202211807.6sca4ppezma7cyev@revolver>
In-Reply-To: <20240202211807.6sca4ppezma7cyev@revolver>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 15:36:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
Message-ID: <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 13:18, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> There will be a larger performance cost to checking up front without
> allowing the partial completion.

I suspect that for mseal(), the only half-way common case will be
sealing an area that is entirely contained within one vma.

So the cost will be the vma splitting (if it's not the whole vma), and
very unlikely to be any kind of "walk the vma's to check that they can
all be sealed" loop up-front.

We'll see, but that's my gut feel, at least.

               Linus

