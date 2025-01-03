Return-Path: <linux-kselftest+bounces-23872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A5A00B35
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03573A3B3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109E1FA25D;
	Fri,  3 Jan 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hf1gyue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997CF442C
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Jan 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917249; cv=none; b=c1JU1xarVUjkGKPK1COfgk6su2yNpBT5GzOFAURz28RhkBJstrURXXMFzFB1TPwWIGZHj/w3hq/YNshuOye0yz4xCfE4GYvfXTWRILYD2IGsPXbfWPHB4FCu71sngOnyenYPkJEOs6x3gvp5NOJ9f+AS5aqr56JbZqbVtVP7k28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917249; c=relaxed/simple;
	bh=BOO6Mceb1cq9EWlEm8iseaAfO9VQLuFkjdeK2urpWwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt4bBrwE97kzRqQQIgoj9pQTKfSiFfJMceHuzNoKysy5+MYkPOgVBnNFQHPX5Kt8fJYXKlpZKv4m0zlUpMtADn8SLx7kdDAuEXau3iSt9G4dBHhXWDLHPpIiQ/EswsvfSj7IKrVk0P3WmhoUDAtb6dqaKCsEK8IthjcJQTqzUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hf1gyue; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso8749a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Jan 2025 07:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735917246; x=1736522046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlyvq3AxGGQPA6vuc5Dm8BwxgLPTSqsUU1yRCgwYOBo=;
        b=4hf1gyue7L5r7o8JEzmhaS8MYiurBwNAtFxtQhxVqGAGGLl1RZKFuGI+V/TvQT+tW7
         j7+Qy7CgN+fSAlO3UzKVaIU1Jml4voyhWjgb9Am30TZQk8yLUfrXP+IObwb3RCeWxRh6
         UTvE5P2ElK/IyKyT9byU0hNO1X16u6AuAei6flQleY+ZkxkJYts/ebiO+8QjwULqhRUC
         hLA40Hb0PxbRbaVDrXtklgzKcjS8aNlHZ1OSg1QkuL60+GWaOwiY2Yizd6UhA7u6ew2M
         ouZkoBRurP2+og9ppaWoEDg75KGWrvDJNWMUmoaZlhQqMBsdU20YAt1kHc9xsSuDHmoL
         KVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917246; x=1736522046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlyvq3AxGGQPA6vuc5Dm8BwxgLPTSqsUU1yRCgwYOBo=;
        b=vPXs2ygKYInjR6jyf/C1NuOw6a2o655DAATMsufS+5WBUPexrtnfOnTQN+BgVDOerW
         gPco9mQOi7Gc4kZJrOaWkPuOUWBEHzfY4WR/FHXWJ2SK7kFADIezxAc6Od0AqDf+lrCB
         xE0yNwtrbYettE2MOX8jdk0LeYjDWbD0+LCaAR78lqbd+iOlG3T7jaGBbta8Rys6URkE
         FoqMSVBok9eHY3Vz0RvhPhevUkz5jmY7fmB4ExC9Po8Iuy43PNhiTrpL15jsm3qlKB8u
         d15Eq1SIrsUeGEIyvEqwP2SiFxGDTtrkT/ggxyVcdeTqAtgQd9qQuLbOep4gUVuMyhMs
         VVww==
X-Forwarded-Encrypted: i=1; AJvYcCWM5D2SZn1A+lqZeQVqf2O/fdp9jXQ9tQxNn+TS+k1iSKC7rOcSLwV22+GVKyn5kVEMlXPmYuB5feZtNixNBbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNlW5chq2Pyng4e80SImeZIy0gJG14oJmgy8BsI3xb+AWf+Gd
	H/vgjvXY5Vl9nSGcA1VbUWASTJp/Oo2SkzymbtYPT/tygVm6D+palBDk4JQvqLXz7vFYlX5ghc2
	rqiIB04KnomL2CP5lr7irpqpdV/ySth+UhrHG
X-Gm-Gg: ASbGnculZMOsBOJDRcN05prkkHBTQuYMr7ZdBp+en2O0NmG3stWMrCvRnh3yR8V7QiH
	nJkMB2eCI7YG2Tpu4jJrOy1FsRYRtpk80O8vIumAUljUbisRx/P+cBGsgpkcE5aSr5Q==
X-Google-Smtp-Source: AGHT+IEE6Z6Csv7Y7V9KFtLA++eWInL/BGHjLilU+NVh+pF3/5irTnuBYbk+Tu1ZwwcGEkuXZWEwDwgvaupqQBCYKic=
X-Received: by 2002:a05:6402:538b:b0:5d0:d7ca:7bf4 with SMTP id
 4fb4d7f45d1cf-5d9156e2c80mr71517a12.0.1735917245511; Fri, 03 Jan 2025
 07:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com> <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
In-Reply-To: <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Jan 2025 16:13:28 +0100
X-Gm-Features: AbW1kvaGhgvt8h3xpCBpboR0oJNSmluhuHWn2o3nP9fdHRR9QmflBGC02PQRZsE
Message-ID: <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 7:19=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > +             if (is_exec_sealed(seals)) {
>
> Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's executio=
n?
> I've not tested this scenario so don't know if we somehow disallow this i=
n
> another way but note on write checks we only care about shared mappings.
>
> I mean one could argue that a MAP_PRIVATE situation is the same as copyin=
g
> the data into an anon buffer and doing what you want with it, here you
> could argue the same...
>
> So probably we should only care about VM_SHARED?

FWIW I think it doesn't make sense to distinguish between
shared/private mappings here - in the scenario described in the cover
letter, it wouldn't matter that much to an attacker whether the
mapping is shared or private (as long as the VMA contents haven't been
CoWed already). But you're also right that in the scenario described,
an attacker might also be able to create a writable+executable anon
VMA and copy into that, or map another memfd that hasn't been sealed,
or stuff like that. We can block such things - but not by only
providing sealing operations on individual memfds. I think this
instead requires policy that applies at the process level, either
using system-wide SELinux policy or using process sandboxing APIs.

