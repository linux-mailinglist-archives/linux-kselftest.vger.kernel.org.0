Return-Path: <linux-kselftest+bounces-22556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F789DA0F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 04:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FD3286D08
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 03:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8E80C0C;
	Wed, 27 Nov 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDt5o1uP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26D48CFC;
	Wed, 27 Nov 2024 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676383; cv=none; b=qKRJDXleVcWWpgxZ5cNv9hnCGUu50QoVZQ/RZwHudVbRTJz26jB6gVrAQ4uJCKLyFwXL8qPjZfBxVPNkJ6WiE3EdvcK8FVvk2ua0G/uK8VN0ETZLQWz6VBnQb5aipLonSgGEGUA3NhxYpAVnmQFyOQqkDcRClBCXoLbO2FOlF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676383; c=relaxed/simple;
	bh=UWmMiGZqLwobInZyxFH3bSZUtPpteFtRWw6WLfPhbAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdTKRpewiQyTOWUtUh3nbGhbVnmA1lWn+s10ccryQYwtNCQ/1wQdmMhYwSJEmfLaXaW6oR+suqa5lv3PCK3yWJeIU24XRwkaJajICLJjhLV5t9pe624niMyTL2tyLQESJJIF+yS8/8PJ2+c6NGFX8+TfWg3a6EUCGig+DIeAUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDt5o1uP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7252fba4de1so422120b3a.0;
        Tue, 26 Nov 2024 18:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732676381; x=1733281181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDren5ADtiyyuDojahly2+sSPvL0WRct0w89l8MBRc4=;
        b=DDt5o1uPa0slHN7y90e0+yWLE5nGk2+X0GKpsY1VtlPA9iB2eXtfaCd/zJzC0wQkHp
         8vwHm2lTGbFnTj5FS/mqdOtiBYM31GzVa3j/Yrt3h3LF59xrgxWEFYL+xjbRZc2nNapN
         G/RunpAAUj3t8FhdpOqAmR5HAbE15Y2jcYmAw8T17HSpqT6Jyue0AXmWHo4MbsPDClCV
         KRHXBlolFsMNMu1mfVG56E+inoQbKswLNcI3hgHbF/gOqIKzBAB4kGY4gXcjmsUU8Yes
         vPmT/xLShMIhyzy/VIkv51Vj5GZjQe/Fe/XbaNdVb4bRI3F2ndiMfm/nnegtguc8Hiig
         WHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676381; x=1733281181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDren5ADtiyyuDojahly2+sSPvL0WRct0w89l8MBRc4=;
        b=dB4oRNU9Tdkq1oQL47E7vAUaAbLafOkHOyAJaQA7WO/xUbrEnPjZEphbVv2j1Zr+Wr
         Xg0X0AQZjzURRnTn1Rn430/DM8gzaY5O5mXYhmxwjQbsn4HDOkJbrEyFWF+1YryxceWw
         AsGQj4J1KSa37JNpX4Z82GaYCW8J5xMLW7r8HcVUwN9/HY06IpiD3RlTL+LrcyVG+XeC
         MsIl3ERfKyPbeWJzgg99oFeyEoOQbIJt/9yj2yfyt25+fj5UeP3o9YUesr1ptZvD9S30
         EEvfgUaNRACxYlGnZj5uevKcFuRrnEh6O2tZ3FT9sERJ4oRySmbOokit+b3k4vnbvMTA
         NHCw==
X-Forwarded-Encrypted: i=1; AJvYcCUjCtcTdUhwjPTKOUOJRXDtNSWBN14ZbgH1AH0hnAtqFM6LBKGD7TOSXyhxD1X8v99gmSd0sUnE5POS4Y9EQN1icg==@vger.kernel.org, AJvYcCVJKm/OQ+Ra7fxS9Y5iMuGvV1XIQfBzgXDG1OVKBO2MbopBRn0P7gW0UY8LRTckZ6JyDVpKoM/6vQjE@vger.kernel.org, AJvYcCVdT7LcwQ14N124yuJs4PHI/FIF88taSxDys7BbXqMYYuEJTcuw5GXXx9c2Jo4ywbsuUeRkunWeF3sTwSiz3oQ=@vger.kernel.org, AJvYcCVrZ+kwkfs27aqNvgm6G9hEUWHQmf8qzJR+TQv/cs18WUzCHMkvThxo1IM7j4K62p43VsosDuSqDyQ3PEYFhPxW@vger.kernel.org, AJvYcCW0ouRepxq3CcucvysfMlZ5DP4Mghdhl2xpd0xlOFrSOZnKoIJG8g1HAxJZDsiLuPf9DZ9xc/4mcQX1ZIM=@vger.kernel.org, AJvYcCX4f1gHc5XSANOmfWTM00Kl6NiipvgC00tag6TWsqv6c1c6nLgw5ErcKWnqM6zX+humNlIV38aNWxntXrYj@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0dR6TfWi2MBh0gLfRq1PZt9Pv/erHH1LgO7e1xw2AzKcPogi
	2MjCrj8GGEmtDtXVKXZawwWsDhdI4D+SUxZKvAarBGhZV7dk5K8c
X-Gm-Gg: ASbGncuSaQY2TwiMlFvnDLFoBEigNj/fQjZhqaI2cyyfJLHeQpK+y9m4bfyVEmDiNIk
	9GluJ7V4fmv7WaTIWEAvZbGHwcwV7ETqHJ6sP2o+vs+D+zRHhH4E4tuVkfbthpC9Wm4e+RDL/0Y
	NtpaKGglE/uW0ck1vYKkCKoc+Tw+U7b95LrT8/BeRCEtSgR4xAWeNVQ4AcR09ASibyzBLWxpcZO
	HcRDRRf0Je8AWFnRk3FeFX/Q31N4q1eaMWrx+i4zDR7mQRIs4jbTtadHrqpWhtEaKPVz+B3fyJZ
	aA==
X-Google-Smtp-Source: AGHT+IFYiHisxMljvlFNcELzBIZNtvqA9E+SoH+TzdKr80+88ifldFSahzOnnXPVC3c2OejQpqXMZw==
X-Received: by 2002:a05:6a00:1da1:b0:725:3305:1a7e with SMTP id d2e1a72fcca58-72533051bb8mr723576b3a.9.1732676380691;
        Tue, 26 Nov 2024 18:59:40 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc40143esm9471790a12.80.2024.11.26.18.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 18:59:40 -0800 (PST)
Date: Wed, 27 Nov 2024 10:59:34 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com,
	corbet@lwn.net, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, willy@infradead.org,
	jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] lib/min_heap: Introduce non-inline versions of
 min heap API functions
Message-ID: <Z0aLFidHu/msXbXq@visitorckw-System-Product-Name>
References: <20241020040200.939973-1-visitorckw@gmail.com>
 <20241020040200.939973-2-visitorckw@gmail.com>
 <CAMuHMdVO5DPuD9HYWBFqKDHphx7+0BEhreUxtVC40A=8p6VAhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVO5DPuD9HYWBFqKDHphx7+0BEhreUxtVC40A=8p6VAhQ@mail.gmail.com>

Hi Geert,

On Tue, Nov 26, 2024 at 02:27:09PM +0100, Geert Uytterhoeven wrote:
> Hi Kuan-Wei,
> 
> On Sun, Oct 20, 2024 at 6:02 AM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > All current min heap API functions are marked with '__always_inline'.
> > However, as the number of users increases, inlining these functions
> > everywhere leads to a increase in kernel size.
> >
> > In performance-critical paths, such as when perf events are enabled and
> > min heap functions are called on every context switch, it is important
> > to retain the inline versions for optimal performance. To balance this,
> > the original inline functions are kept, and additional non-inline
> > versions of the functions have been added in lib/min_heap.c.
> >
> > Link: https://lore.kernel.org/20240522161048.8d8bbc7b153b4ecd92c50666@linux-foundation.org
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Thanks for your patch, which is now commit 92a8b224b833e82d
> ("lib/min_heap: introduce non-inline versions of min heap API
> functions") upstream.
> 
> > --- a/include/linux/min_heap.h
> > +++ b/include/linux/min_heap.h
> 
> > @@ -50,33 +50,33 @@ void __min_heap_init(min_heap_char *heap, void *data, int size)
> >                 heap->data = heap->preallocated;
> >  }
> >
> > -#define min_heap_init(_heap, _data, _size)     \
> > -       __min_heap_init((min_heap_char *)_heap, _data, _size)
> > +#define min_heap_init_inline(_heap, _data, _size)      \
> > +       __min_heap_init_inline((min_heap_char *)_heap, _data, _size)
> 
> Casting macro parameters without any further checks prevents the
> compiler from detecting silly mistakes.  Would it be possible to
> add safety-nets here and below, using e.g. container_of() or typeof()
> checks?

IIUC, the concern is that passing a pointer that is not of type
min_heap might lead to compiler errors being missed. To address this,
one possible solution could be to expand the members of struct min_heap
into individual parameters for the function.

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index e781727c8916..ebd577003f0b 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -207,18 +207,20 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)

 /* Initialize a min-heap. */
 static __always_inline
-void __min_heap_init_inline(min_heap_char *heap, void *data, int size)
+void __min_heap_init_inline(int *heap_nr, int *heap_size, void **heap_data,
+			    void *heap_preallocated, void *data, int size)
 {
-	heap->nr = 0;
-	heap->size = size;
+	*heap_nr = 0;
+	*heap_size = size;
 	if (data)
-		heap->data = data;
+		*heap_data = data;
 	else
-		heap->data = heap->preallocated;
+		*heap_data = heap_preallocated;
 }

 #define min_heap_init_inline(_heap, _data, _size)	\
-	__min_heap_init_inline((min_heap_char *)_heap, _data, _size)
+	__min_heap_init_inline(&(_heap)->nr, &(_heap)->size, (void**)&(_heap)->data,	\
+			       &(_heap)->preallocated, _data, _size)

 /* Get the minimum element from the heap. */
 static __always_inline

Alternatively, we could use container_of() for type safety.

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index e781727c8916..fb96b1b82fb0 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -218,7 +218,7 @@ void __min_heap_init_inline(min_heap_char *heap, void *data, int size)
 }

 #define min_heap_init_inline(_heap, _data, _size)	\
-	__min_heap_init_inline((min_heap_char *)_heap, _data, _size)
+	__min_heap_init_inline(container_of(&(_heap)->nr, min_heap_char, nr), _data, _size)

 /* Get the minimum element from the heap. */
 static __always_inline

The first approach has better readability, while the second minimizes
the changes needed. Please let me know your thoughts.
> 
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -777,3 +777,6 @@ config POLYNOMIAL
> >
> >  config FIRMWARE_TABLE
> >         bool
> > +
> > +config MIN_HEAP
> > +       bool
> 
> Perhaps tristate? See also below.
> 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2279,6 +2279,7 @@ config TEST_LIST_SORT
> >  config TEST_MIN_HEAP
> >         tristate "Min heap test"
> >         depends on DEBUG_KERNEL || m
> > +       select MIN_HEAP
> 
> Ideally, tests should not select functionality, to prevent increasing the
> attack vector by merely enabling (modular) tests.
> 
Makes sense. Thanks for catching this.

> In this particular case, just using "depends on MIN_HEAP" is not an
> option, as MIN_HEAP is not user-visible, and thus cannot be enabled
> by the user on its own.  However, making MIN_HEAP tristate could be
> a first step for the modular case.
> 
> The builtin case is harder to fix, as e.g.
> 
>         depends on MIN_HEAP || COMPILE_TEST
>         select MIN_HEAP if COMPILE_TEST
> 
> would still trigger a recursive dependency error.
> 
> Alternatively, the test could just keep on using the inline variants,
> unless CONFIG_MIN_HEAP=y? Or event test both for the latter?
> 
I think that having min_heap_test continue using the inline variants
might be the simplest solution?

Regards,
Kuan-Wei

> >         help
> >           Enable this to turn on min heap function tests. This test is
> >           executed only once during system boot (so affects only boot time),
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

