Return-Path: <linux-kselftest+bounces-41790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6795CB82276
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 00:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A0D46583F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF230E848;
	Wed, 17 Sep 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0xhXweG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DE30E826
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148123; cv=none; b=bksJ24Sd3PhLNE5cLs+j2TmfR4fJuiVxto3SWO0RMAQLRhfg26vcV4o2xWiZasPzxyYJJFKLo+0lvnHp5eIMvSUlrPzHw0+Fw/FXITdm2s+fQvTpFjSpLhn4EtMuyZbdBozE6wNZheFdacbCzBqXqaBdzLrcU1nw+5MRpnxc+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148123; c=relaxed/simple;
	bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxpKhc+/N3sNMRuWgCb8hBwpLOiIRrDWv0Z3DPygKJmqubpOxEwJzjXaIl4VKUto56dgCmrdWYg3LhJkA0jXac8a8/d77GCOISiyLBZjJvDBXtxc12hR98uyRypwMJZF7bvU9eFJxJ60bzLwhAoycdi5FZ8OJ8VWGt89qZwzeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G0xhXweG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b5eee40cc0so3125701cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758148120; x=1758752920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=G0xhXweGeD4m22BpUYK2rJAB1NzwdepdngJJZpyLeE9M2TXbsH9EtKpq+2JER/nUAa
         MqgkbSIDErbjdl4PWvA92cImUwZw93ajTaErws2Cjn17NLcx0QV8JblGkxbIMQrwD9x0
         jGY3oh773JJCAu8IIEC/+YTNwLJhA9qOmFBUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148120; x=1758752920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=uport/Q1scmruJGHP+F/FziZ6TNTnFXSeJNWCWpJS5UlgO2On+WvkrYcDgKWqM+O50
         QQufvQj/w3OuI70pAXOLnjJOkarD3/rq+JOg0UE2q2EsSOc5BkQHUbC0FLBTk+q+KhSd
         KpUhXp04c10ReGxb3/BVSZ9CsyH/Dm2o9tcJDyp4kUp40EZkpsrplBCfJcNoZJtKcw9m
         hNubxqAZaTk72gTKOBH7PP2JlN+G99qDFqLT8orSp/1GGtQQH5hoes3zSg9DCbtw79Xr
         yiTUZxrYkEowZsO+O81P5FHrJbO95mj/sL///Mq6vYSr6c3Mwvj3gyjS3JM5azFtBy1i
         fPBw==
X-Forwarded-Encrypted: i=1; AJvYcCUAb+yZhV2gTjx8+UcyBpKiwlZb4OzNhJcjwvafDUf+mvwKx73jJqHR09l+apXXUfMcHsJx7KDtUMPpLTJ+Pxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCRMAO/M4pL0/IpsV/3kqpWG5U91GLo6PWiyXmICw/cAtFFQ/
	1xBWrOC3jEA8aTCcVBK1WmOXrcuzXBgLc4hHKm9ntUGz6evPCxuXCXpbu6jVlOT5CGJ5PBraD8X
	rtNA=
X-Gm-Gg: ASbGncslE6HcXHapidEAuAD0h4MLSkaFnlQZQBoHV4EE08ABzPM0ccCXhbaMc35HGn1
	Hw5PJ7MF/DGd7BocTFbu5qM1KKsrrYz8zGdwBGGJQwg6R/q0EcMEnTaaN4Y8ouUseOPzRHxTxqU
	DtMZWn56ayod0k4GvfEpnrFSggpQlBmqHujZAQqw5OTL8rsGyUyRwM8/17k9BC+YZguTK3X3EwZ
	IrEIsqSiWd2Zd133JPONEBIiIdB5u5v1nPV7Brq/IYppcB4pp5givecspL+lLXTWxf6CoNNPVX1
	ON7EG1KGJK7sEJfTIV9v/t7K0jM+yJEhOJBzHJhLWYJ6R6/8C36bYiqMneHqj1AhcGM7TsR3NN2
	CwR6lgvrfdf99vWKfHhpBhdExa8SyoUMHWxd4FocAXHMJfZR8PCSVhCB4zsTVf5s5Ge4n9gLuzS
	p2ZW4OaalfBwr0PYKg
X-Google-Smtp-Source: AGHT+IF4MgSxiv6NL0o8RY7t38UJHj0nVazJlFB5xvoUZUUw6gmb0vKeF7LbWUEjSr4yPJPjbKDWIA==
X-Received: by 2002:a05:622a:199a:b0:4b3:4e8e:9e4a with SMTP id d75a77b69052e-4ba6acaec0emr46035981cf.56.1758148120351;
        Wed, 17 Sep 2025 15:28:40 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda28926b6sm4401161cf.20.2025.09.17.15.28.39
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 15:28:39 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b4bcb9638aso140511cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 15:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLrmz7bhKk6FoZ4T87gvOort7COen4oMxEEhqx5Q1WcZFF/jBgWhBqN4f6o/E+vxCK1s97TvnJdC+/Ie37oK0=@vger.kernel.org
X-Received: by 2002:a05:622a:290:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ba2dbd91e3mr7888171cf.5.1758148118686; Wed, 17 Sep 2025
 15:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com> <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
In-Reply-To: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 15:28:27 -0700
X-Gmail-Original-Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
X-Gm-Features: AS18NWCUMtpdk9H0fWidPAaF1Bc8oxlz8rdMZKPuVQEPlj7Pq_GvycrjQRByVOg
Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:03=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> One ordering thing that sticks out to me is
(ordering can't help here since we'll rapidly be flapping between
ovflist in use and inactive... right)

