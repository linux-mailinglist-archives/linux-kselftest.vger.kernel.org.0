Return-Path: <linux-kselftest+bounces-48273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA2FCF6740
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 03:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD414313B4AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136B2C326A;
	Tue,  6 Jan 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP0wzhJk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E8239562
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665760; cv=none; b=AOzl4PygXzcFhbQaegmy0vBalAjC/JwuESzp3P1YdvA6HDbZXHJ+tBbq/7oqKAwZpCroqnf1QIQ+BsOS455RkeqFBfpRsuViJKmySTR9S9pW4JtNTbwWeM1Ls/FF9vdJAE8Q3OknVcpyCaCxuM+laJTdUlgXlxNioNzk5YQSyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665760; c=relaxed/simple;
	bh=KFKQv2r3eWqnikxLSVGzdUh1ujEU3so4QdL9eMYB7pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaK7EN7zpRZB6iXcBlxlQi65C5UgoLwpqeyhPBrPStsKjcHloLjaRauridILe3IWInKBVzo+zX8GNtgCKf9XW374oPex8/wU0+FlBs6uvQWOudBDauVOPZICVMnvhOHU6KAMSTB6PL79PhKxib35njtQ5N7ml+9bw7FSz3bW+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP0wzhJk; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78fc7892214so7045917b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767665758; x=1768270558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFKQv2r3eWqnikxLSVGzdUh1ujEU3so4QdL9eMYB7pM=;
        b=TP0wzhJk0fOc613zkTf1C+Azm0ZkWKTc/8N3Xdu4eH4hZzZwr+vCSTfHqtWhdsmaD/
         bKzbeuaP72mGOz0nn5dQJfHqwiIXW/cTfALehvGEdAxqslJvKD8EH2A5uCM164OCGVNV
         CXCPoVzk5MMNhAx+5hPKYkv3rLE417MnBCz9A46Kfd8UNW0iuXHX/5Eb7S4iFn6cqQzZ
         5sQ03KsKa+SE2zGElvm1KFITwcYOvveNw53kKBSXklnfgsz4W4EvDQleXgywaTxOCzq4
         oKOOAU83QsDDSQ4nBy+TCiTHQj/2BLI6rgpW6j++/UZLSO6Pef90rq6YSfO5yBmU9VN8
         z9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665758; x=1768270558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFKQv2r3eWqnikxLSVGzdUh1ujEU3so4QdL9eMYB7pM=;
        b=osHAx+mnzsmy6Yq+mi7Q9jk09+wRL4nCYzILP/eyfpD2KL0gcVlM7zfWUutQsAb36k
         EQAF13FUvMf7eea6VgymgbSp91DbWFOSHdjz9QqhxqflNER19DJWnJN5zowAYu/S6kF9
         UUTHo6gI42rtJJhyyJLnOfgwbRFb5euOWAUYAW4pK0L7Z350Ny4MFI1ukjFD+btx9Bug
         tv6JQhcLy8bcB0ohx/0q0aeL468OWkXybrH3eXZa2dQ9HlyQNQ/ZPY2FJ45NrkJ8vVET
         FtdMz5zPG7dGI3jbQ+SUCQfLqUirk2aU7pFmP/s/1vxZrqIn4ALA8TYzOXcBIuIisEld
         ZRug==
X-Forwarded-Encrypted: i=1; AJvYcCXQFa7VaI4C0KFC/LJp1Z8R/L/uBElVOu3r9MWQvdMAtLKmbYr5zbIjiysFCT0rY5+GG0oKo+pj4N0OPjykdv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQyQLFVZ1fYSRQ+Cx++b1ftp+Zoym15qvud7I3RkIYij9m6C0
	jCkgOOJG/Dd7l/1zEr4+GRo/zvcWmhaNLJX9I3sef91k21zrF6jBlxk8plDqT8mmqCKomkrU0NO
	OfL7ADBzODKFcl09G2HvBeFXiLp3qExs=
X-Gm-Gg: AY/fxX452vkqjViv+8/XcNsz9TIRfJCnV/7ZRi6z4Z2tSavL9THbgEYU/IogOKnHvL2
	1e4NkBVP8yOTr1EtICsqt3cNmXZ9AgGvyqEHr1ayPiZM6vf0zevulrcvX+oVHIREIuOS7GxVQuR
	xH3ZngnFDe/9riKFNydFQbr1HnIRdp9dx9jkDjAU8gOsQXgWjHghDDT5TxOFYgD6CngxeO1ob4a
	+mz0mR3HKuuMvs3L/jjadeQLDikqid17g1oKcjHtoKytuOMwmoAPAOSzlk/eUSi7752Gjd7Ap5s
	v2smwtOU
X-Google-Smtp-Source: AGHT+IEuoYm+bzvqZhk4qg/A4XrmfEhgVpnTZ0+iG9FOGEwqDlWTCZKfH2wbr1nFvQ4jU0oborf9p5hfIyPDSKcCa1s=
X-Received: by 2002:a05:690e:188f:b0:644:6f3c:11f3 with SMTP id
 956f58d0204a3-6470c85f217mr1377138d50.27.1767665757810; Mon, 05 Jan 2026
 18:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231184711.12163-1-sun.jian.kdev@gmail.com> <CAADnVQLUzhEi=T3shodJ_9N-e+=epH52Ui=B=2eFXMRfZf8jTw@mail.gmail.com>
In-Reply-To: <CAADnVQLUzhEi=T3shodJ_9N-e+=epH52Ui=B=2eFXMRfZf8jTw@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 6 Jan 2026 10:16:01 +0800
X-Gm-Features: AQt7F2pZTZFApaEXJLIPVtPv0XKDWKU5mlw01GM4QZNDB9Ur-GVrYMXHYBhMmoA
Message-ID: <CABFUUZHY-T0O9k2SQJOh8+JnJcc2PDJFxz7PAa_q0VVMbiNATg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix qdisc kfunc declarations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 5:34=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> Stop this spam.
> You keep ignoring earlier feedback.

Sorry. I misdiagnosed a local build/setup issue as a kernel bug. I=E2=80=99=
ll
stop sending patches and fix my setup first.

Thanks,
Sun

