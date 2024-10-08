Return-Path: <linux-kselftest+bounces-19254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B79D9955F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F01C24C0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835D20CCC9;
	Tue,  8 Oct 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lys32wBd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B51E0E0D;
	Tue,  8 Oct 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409697; cv=none; b=EnjA80Q7LRvwbnB6LAKJ5RiSl9bZe1rsF4e4HZAQnEvKkWZxuIICSlvt5FJRK2L4O9MZEQTbB8GrJEV7q12VmNfV3j6l4BNbWNKq3qGOAc9McU5vjkIsFik+0YVs8ZR9zIRZu8ZA4e8KzS/BmkRBUJ3IFVDOzPTYSsXbhbqehQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409697; c=relaxed/simple;
	bh=HhXUWNyCd7lrYs51HTyxgHt+jQ/qZ23wBJfVorotGVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLv6jiG+FRvlnQzttAFeZfLU6iK7oEDSXUwWgbLWm4qrhqSMLTO2+Lmv3fh/tyPfGTDspGrGEHwAdgMQU4utT8Tu3vcUwfTuoGwrX/OZH+EgZwTZocEAmAcgjmxIXHVEhCeQjejNkFtO/CJNGFyTrE9qmJ/pof2Hz4JfTi5TM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lys32wBd; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84ea6ddb972so1490065241.1;
        Tue, 08 Oct 2024 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728409695; x=1729014495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhXUWNyCd7lrYs51HTyxgHt+jQ/qZ23wBJfVorotGVU=;
        b=Lys32wBdOJK8mpKWThm53yA62Fa8735pO24SLzIyKorXFkdUtfU4oF09b1UFisvkb5
         IkXU3Uaf8daYvX3qYbGplUW3Cy0qPw56qvJaUXveJymsk8ip+AWpve6frExFwDOpTrgA
         FsXE7IuPO2Nb1unIgaJSmZxvdQOhvHXcmrNX2sL9C05menADpV1goQo5P2RbEmKaPyA7
         YIaRCpHoAL6m+WneY+pWmzgMO227FN4geDzfiC0ZxowdXOLlbIld5x3YplXLC2MYGflV
         5Va1dfbct0R++T37XtJmTOY8iE8+qx/qXvflUVfKCEbiE1yeMOD0Raloq/mih0b5fckW
         Ph6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409695; x=1729014495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhXUWNyCd7lrYs51HTyxgHt+jQ/qZ23wBJfVorotGVU=;
        b=Yout0miGnwl+ZIJMj2empgRkzdpsHUUZq6wEwoL20jm3twT2X7E5Mt9MzEHzQEFKgm
         OoO2L8BHdayrOju1kmYFDEKRzuuMv70I9Cz0d2h2KGKHFYofyCtpqM1wNnZTuqM/8Yim
         VRJz0vJCjCwS6COCIM654K5bOH64FSPhodQWmGlv5oEJvSegLxf7lHPtXE2acwldvLz/
         znaPbbAVBDmPuKPD8u+UUXQjqHr2F4VGLfOYB43ObDVY383ILAAa8jLTqY5nQDMczrbP
         FkSuhmxKPE4SB03L2FkHFtqUmgX450Pf3ZEna0Vwz4yoU2eFeH8av2dl/nYHMMMQFHbr
         U/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIoieTewJ+F4E7YLf0+bhQjSsN2SS3dwUfjTD4mh2kqmyiWn4ut0uq49NE4XDS9vN9xvoVx01rWzegS9sC@vger.kernel.org, AJvYcCWWW020AgnEROZBpTgYU8ozps0aZRz+vzaf5rLvJAaZgDXVvyNQz3l1yqmQHwbaPdsY7oQTtdLZA3uSpbi8WGoQ@vger.kernel.org, AJvYcCXSbidrR2h7AX3H9qf82yJSSHcb/gNIpcSNaiYJdUXKZuXwQWUlkXVrVffVN8vzMctskwBJEFkHZYDhySL1pBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+1mzxy6PdyQusIb/s50DJmxwBperXtn0TAySYo0hR34znUxy
	ASCzv0yIjNEQ4BP4zNIGs/VRloyC4zCBYYIQQ1AXcO8aYDKzn3PizOQ3UuUtMaNAimyAMQg+L3d
	ArEZ3sOVqZbf8Wqw9ckguKXmKmPI=
X-Google-Smtp-Source: AGHT+IE8DwFUrBVwR9yu8xxyR0diuB6FJKrvPkKyJpldYZwYMONMxddkQUAXPqwt2kCf4OmdefDHRCj+Zs5EpQhOwys=
X-Received: by 2002:a05:6122:a09:b0:50a:b5a3:e00c with SMTP id
 71dfb90a1353d-50c8544edb9mr10418552e0c.1.1728409695131; Tue, 08 Oct 2024
 10:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008040942.1478931-1-jeffxu@chromium.org> <20241008040942.1478931-2-jeffxu@chromium.org>
In-Reply-To: <20241008040942.1478931-2-jeffxu@chromium.org>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Tue, 8 Oct 2024 18:48:03 +0100
Message-ID: <CAKbZUD1uyzhS6C0T_F_U+4gfuOcHFMJ-82XsFaLZQj91F-BKZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mseal: update mseal.rst
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:09=E2=80=AFAM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> Update doc after in-loop change: mprotect/madvise can have
> partially updated and munmap is atomic.
>
> Fix indentation and clarify some sections to improve readability.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Please reply to the points I raised:
https://lore.kernel.org/all/uwwg47m4mwo3g32qavzr2mjmh4r6lcm3irr3wtlvedlylbq=
74z@flcq2kwvmh46/

They're actually instrumental and something that *needs* to be written down=
.

--=20
Pedro

