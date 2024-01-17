Return-Path: <linux-kselftest+bounces-3129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36E82FE85
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 02:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A945928890D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE61364;
	Wed, 17 Jan 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKqPz6hz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106C7494
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455843; cv=none; b=tBLzQCWzLR8Ho4ljPISPhOt/T4zih7Fo0PbuYa4MhCA1Ajk4HpS0Jlb1SsZ8ZIACSXh4EFD9wUQE0UR4Hndr5Eb8M/iXXc5r7Ncj19dgfv1TevOvmgiCzGOX8TsgFg1y/2Y80T7F1E7rETBY/EbnlnEF1OiWCPUyV1+vVCSxfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455843; c=relaxed/simple;
	bh=3Rc/iB6lpKaZmLswe3EBoqxgNQFU8aEwulkS42oghdE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=RqMACzko5Be4/dBTka93qYOXISwIOiX7gD7oyfUAY0Ss+wkJxV0OonQvJFUHF8bD5yJAY8lHHP4KoRyuGCa59csRMHkfNJXoObdhD8sD8nan5UjyMoZIesKid17vCcfPBO+yCa7moRoUYjTeE3Z9LOxKWPrGA2E3T43FGNjxE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKqPz6hz; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dddc655a60so5187114a34.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705455841; x=1706060641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCyW5jgYL0FNfi9sZFaXkPZnRkjGgNqTM8Cun5y6rJM=;
        b=HKqPz6hznYnZNcSvv6+JRTq0qHiw2CjjJfH6j25HrK+deJ7ihcC9cmXhmkNxwPX2AZ
         SIHSwBltMqI4/dVjB19SRD+u7L+zGwREhe7yGBh0blNOwy+Nabn1ovYQqkNXD8T5auqA
         FNDfe2QJRQ92zgP3GjbXiSbIp7pklZp+F08xooi2n0v4tKMbrzy1ZGpdL7LDLpuXfapo
         n+tOQtC5ndq2MqjlIZ6q/XHlPpmudn0De4yiAGUTJWTv8QCaJjEP+KGz61GhPD6SGO52
         5tYNN48M3Fc7fg8nXKH/PzQlZWA4VPm/3AJUz0MRb5Rky4VZesjIk0GhOOVFFADm9eoi
         ktjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705455841; x=1706060641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCyW5jgYL0FNfi9sZFaXkPZnRkjGgNqTM8Cun5y6rJM=;
        b=nrz92DwTq3576iPmdzO1iu80uSfDO6tfo1b1Af6jVWU+I/CT2d1QDJkyeGH+HiqRPZ
         XninyV7Lu3xfg8vF/fx8K03+ZR16h/ILxuRlNGBW4SfCHuTZC14ejHP4it0Mki2o1FLk
         nR7DeVObfYRJ/2Lg/9qXyrz3Ps0qcIl7mzs21MW0dFb+wPcrMRi/PvS0knVlm9tgDc5u
         tITUjIZ4b1nJlKDUHgyrmloTjqZajMrjRzO+4rKsvXcamZJzZrXQtRi6WaE0m+4ngBK/
         pt/B7hHVea6+rj09b9lLsIg8ntSj6kXTTJPwAL01Z/RwL3zwd6QDErmNROSD/g0iLpML
         pbjA==
X-Gm-Message-State: AOJu0YwxwKrkDoianyyQZT+0fEZ7vGW7sNsdcjHIWfZ3oShbYY4k1IZ6
	iO+itUU6ZT3csAesHbggg30dhaX+9gEgIee2Z4/vNmMkEmBG
X-Google-Smtp-Source: AGHT+IGldAD4mdJNoJmIKE84COr9mosuz4vTOr5EHnkC1oq8G7bbXYyK0Di2ree/MvwG/EMobDC/p0sRp20Ly3A96M4=
X-Received: by 2002:a9d:628e:0:b0:6d8:567d:ed18 with SMTP id
 x14-20020a9d628e000000b006d8567ded18mr9306987otk.7.1705455841107; Tue, 16 Jan
 2024 17:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112074059.29673-1-hu.yadi@h3c.com>
In-Reply-To: <20240112074059.29673-1-hu.yadi@h3c.com>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 16 Jan 2024 17:43:49 -0800
Message-ID: <CAEWA0a6CUh+Dma5eCPqM-2oc4Ah8jrFkeNgrB0Trr7paaUT6Nw@mail.gmail.com>
Subject: Re: [PATCH] selftests/filesystems:fix build error in overlayfs
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, mic@digikod.net, amir73il@gmail.com, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	514118380@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:45=E2=80=AFPM Hu Yadi <hu.yadi@h3c.com> wrote:
>
> One build issue comes up due to both mount.h included dev_in_maps.c
>
> In file included from dev_in_maps.c:10:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric =
constant
>    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from dev_in_maps.c:13:
>
> Remove one of them to solve conflict, another error comes up:
>
> dev_in_maps.c:170:6: error: implicit declaration of function =E2=80=98mou=
nt=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   170 |  if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) {
>       |      ^~~~~
> cc1: all warnings being treated as errors
>
> and then , add sys_mount definition to solve it
> After both above, dev_in_maps.c can be built correctly on my mache(gcc 10=
.2,glibc-2.32,kernel-5.10)
>
> Signed-off-by: Hu Yadi <hu.yadi@h3c.com>
Acked-by: Andrei Vagin <avagin@google.com>

