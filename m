Return-Path: <linux-kselftest+bounces-27336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F6A41AD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0996B3AF10D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0524E4A8;
	Mon, 24 Feb 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fo86Tl0s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E7241669
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392734; cv=none; b=LTpnYjrNR+lggwOQ7IxvsLJI8PZPX1RpJKOkYaRpS6neaVZ2e0kGu6tSLznCSSmtAwItPsWqiU3YZww3UVJzGzL/4a0fZH+yZZ1kAW2mfA+fj+5pZsc0jWYZoPfhZ4jNUsZ5DUlXgVdro3Y9NgiZkWWLWL6rBxwbfmEFpJ3VT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392734; c=relaxed/simple;
	bh=i4eleRcznfjhdEtYR1eZovpdeENk7cHdBNblRPiSyMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZ+74KzRGsc0bvFLJ9X4/lqNzbq3ekt3zx9KTyCbejCLNWjEk6UJh/6Kf0oE8U0P+KpdYzO5MgzqLHYhbzVOTqn0Ab/qwKdjVPmLi8oW/cj7302RdWQmcBVy8/aAOOqs1Wz+k0UGYNcUIw8bdnR7RZxmU+9FFuzXmV3klzg7HVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fo86Tl0s; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471fbfe8b89so551831cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 02:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740392732; x=1740997532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4eleRcznfjhdEtYR1eZovpdeENk7cHdBNblRPiSyMY=;
        b=Fo86Tl0skQYbDB0GFyY3+m4pWnTLt4qjzUqbdBmZr2oyaPJWoQ6+2gi28xnR4kePog
         VkdZmmJr9YvRsT8wrdBpAoshDQBlwzMQ9ToXkOf3nZEJMZlLwiJ8BZVD3L0WQqSrhhRD
         loCWorwWpT/3EvDDHRoiqL3KbpbVxNZp65DQM8Xw2QZH5kjuEvB1/96R2cmtFzhdQRXZ
         dXBntlM8sTuzgR4wn07zJEk0MoD/oQe68FtyGnjj2UAYQ8SaMG8yZznDci4pRQFNAS76
         dn85OQpIjBqHOk3Ke3B56Ga+esH7IddOEnxOuxaGknJnrIXF0Hr6e0k1CsfLa6Bq48hF
         QpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740392732; x=1740997532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4eleRcznfjhdEtYR1eZovpdeENk7cHdBNblRPiSyMY=;
        b=xR388PkvpLgQ0fdyAY9ynbLk7VPNxX29NT8fh1oempo78okjfQk2f1JtrRCmRsRqOa
         gYNhGtoZKy6bPG1UF+PIwhHHlDjPMEjmyVKHqfMI6PyeiWvdw7wvwxY15uozQdLyfYKB
         IvAXRQkMUDMgi0LOK8/S/3r2K/hqsjkIwpNOdsm1PKsD9ibk0v3jOcd+JrJ1rst9Ty+C
         A5oSRMeBTLVpeLRe4prpelbmDr4v5rmSP0LZ+qzrbtY4DG7U969c26JuXCrzks+X/VAr
         /JJ91TjHLaQa1IR6e6CTc8tIMML8ZfT/De+JsFO53ozmNToreC9ItqWbONc5o5lJMgTZ
         z/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXi/iqyrHOENpLfXgwHc57ghhipDk5akZaVW5V9pV+z2/Vf9kT2MxA6q2KYiGODBsoZRkaCjKQp+f9+rBh9kbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwN7ZWL+WmoAh59Y4zTEhDatmjOZLjgYTC5RVaVSk8109b3S1
	PG8i2/C8tksDUtU+2uEfguUq1lZT5iHnKTpZlQ2LGlj6qjCg0kRnLNAGSfI9eH3DfNwprf0BbHZ
	XR6+kqh4AlfoN5yRheG/zvW3upwUD747/f6Qy
X-Gm-Gg: ASbGncvf7IVuwqRY01KeaABeII19eUt3jpuwUlyRgkLCs+N6PvwNIXf3fIROq5KxAt0
	Jl7xekFPyJ7JCHxqTzEqbFeuJVzLuwNezlOtRA+bdySAC9H6MfCeFxqP/cViojlwLy/hl12baVM
	3WO5MR5yWgOBdvuTq+9iyhQhF0m6EzSAK8QXLF4A==
X-Google-Smtp-Source: AGHT+IHcORwH6MkXUIuhNvKpirxHiqnifBvxkOChYQByYI8hUWdzlbaftAH/T5c5oza1wGn0qb+0RWy8+yWXJkLeVVE=
X-Received: by 2002:ac8:5912:0:b0:466:8887:6751 with SMTP id
 d75a77b69052e-47234ccbe60mr5534931cf.23.1740392731839; Mon, 24 Feb 2025
 02:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com> <20250221-mm-selftests-v2-8-28c4d66383c5@google.com>
In-Reply-To: <20250221-mm-selftests-v2-8-28c4d66383c5@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 24 Feb 2025 11:25:20 +0100
X-Gm-Features: AWEUYZmHq3d45n5Wg3TPcz7MJBRGHJ_DS5l_Brf3CVevVsclDXFs37_wvvoTAUo
Message-ID: <CA+i-1C3qSSgxJKREyVxFqCwZxGfZ+2962P5fKMATYFLGFb7fWw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] selftests/mm: Skip map_populate on weird filesystems
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 19:26, Brendan Jackman <jackmanb@google.com> wrote:
>
> It seems that 9pfs does not allow truncating unlinked files, Mark Brown
> has noted that NFS may also behave this way.

I have not investigated at all but I _think_ over the weekend I saw
ftruncate() failure on a QEMU guest where /tmp was tmpfs.

Most likely explanation is user probably error (like /tmp wasn't
actually tmpfs or the tmpfile() did not actually come from /tmp). But
still, maybe just waving my hands and going "buggy filesystem, ignore"
wasn't so smart. I should actually understand the problem before
switching off tests.

So, I think this and the other "ignore on weird filesystem" patch 9/9
should be ignored for the moment.

