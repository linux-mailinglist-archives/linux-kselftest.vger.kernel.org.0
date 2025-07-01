Return-Path: <linux-kselftest+bounces-36155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905CAAEF1AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50361BC54B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 08:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F57726AA8F;
	Tue,  1 Jul 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pfGJpfmM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577161F09A8
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359672; cv=none; b=qbaCewzpnjvnW0TgNAwfYCvhQ9rMsiv8apcdfhDEzlZEU2yuztmxXQkiPBpE/OgnmsQNaaRpRFog7nuVkELNjdz3naGZElUsBCtvA2R3ybFjUCwcOJSiWHEb0LGryrTvEMYc3pE1umV1YSHAP4qPGOz4suk1pniNdqj/P9afoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359672; c=relaxed/simple;
	bh=5ikLTc8iKzNYke9+vz4Tcgp3xgvRhKTpysolE+c/wEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJrt6em16VKJHEOnlVeHTT2iVmw9DBRcS7CqIGOYD8MCeYrZIubPnNSyrILN4hPmV29bHjnbgrMLAk3F5iFYZ4PmKEYZGmF/ZGDD7t86pz8MEEU9ViPBY6ZC/YiaZvU+bDHLRRfF+8yFELL0RybajvqRrSQ2QHKWgR2Qyg50hTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pfGJpfmM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 049863FE1F
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 08:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359666;
	bh=5ikLTc8iKzNYke9+vz4Tcgp3xgvRhKTpysolE+c/wEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pfGJpfmM3gGQcYVU3MNZq4J+HMfYB9lOhlIDNK3eB2cnZUXqJUIbQWuGgRZPYnK4Z
	 rmFHbM6D78EbZVI9jzRks3T3Z3lfWOFEGme1CzAEfw2kjHvMFsGTOflEmkrDYZMI7Q
	 KGAu9aOy+4F1ciMGh6gHknpZfUIzqDUHm8IAKcQHZYitcg2aJswCMbPck9ATPFZ8ch
	 CC4WENlGyVH0eY8x+OmctrtplzOmKHOCB6/bQzNn53KYCto4hDAT0LQKEmuvhZomAj
	 ZPLkyQMDkTbaViMcvPbHR5gJrZdjYDl3XBID+zVrdfqTsl9JtaDp9hqDbM3nsZV6l4
	 fc728y0ASDjGw==
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-884f2097b16so2443203241.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 01:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359665; x=1751964465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ikLTc8iKzNYke9+vz4Tcgp3xgvRhKTpysolE+c/wEA=;
        b=q63DZ1yCAAhPK4AgdCje797HOT3dO/KaUzgFMX6sT5hrQwdJlvCoflYAG8V0iVGQef
         /uilrlJ2U9GMAdyTraZauaDvP2Uw4Yf5bCj8sMMZHCSLrm5Pl/cPtzyrVK1nFy/vPM+z
         irXf3SsZAr7tYE9haRFv7m+M+eEKzztE1U4RiDJSX96VTzvDyACgoo5TZV5bgIDvTJ/c
         2SjZHKMSCuuSJavnzFOLbqcqBN1acfgljJ05fmE6MnxdKTAm7Z7llY2+3YHTdAnFDndh
         78Z7uJGxa5JjOwZQnPkQpQSHN56gHzJGgQkyyqKFBdw7sE3Eqa5kKSan9pHKAHHqtmw4
         rYAw==
X-Forwarded-Encrypted: i=1; AJvYcCXtI7IJ7OX0jRmAKx8zrK5MA6CAnt+J9ze2k6tnAl+Kdv3aNu5k3ycSfzSNLpqpDm2U7XUbxrS1EQfNuSYA86s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAmP4PoyaY7P3zzkHoik4vmsm7qVjxCMcSTnsvbP+GWh/lZSR
	fBZlE3dfM7Zenn69iNKF1AYAMwSRnEJzUKKW8z0Q7tesWN+zWhnDVrmH9J+ag0Tq/BW5m4Xt2gC
	bNYGHRtyE2SJ8zH0IUPQMXCQkayBe0304zlGDs+2MUO1OVLwJ4LKDftRddBW8fjvFK8yJN14c2e
	USiYvZK1+aN1z48FtcdAJL0rLGNecLzozuWfe445AKyKIIU69Q9e7BdrBuJZJV
X-Gm-Gg: ASbGncvDQUnJ41CGHiX2j47Iv5lVKM4v14p+2N62mG1rSlD1kDJStPyLrCi0+W/Zn3L
	t1tp+ASdW1OC3gp0O7sx5H8vS00wryxe1EHR/2ptY/XU8F9biMr5ZBlm3PbkeqFauNPQnfDNIAV
	2c0uAz
X-Received: by 2002:a05:6102:2b8d:b0:4e2:a235:24d1 with SMTP id ada2fe7eead31-4f143b1764dmr1631185137.4.1751359664883;
        Tue, 01 Jul 2025 01:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/XfNIm44PW5VunFf6h0jOcW1yP6L42lTuRUgGXOj4POf34vLlfU9zPs6f8E7vyoPOSBamW1MimVgR8iVOnwE=
X-Received: by 2002:a05:6102:2b8d:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-4f143b1764dmr1631166137.4.1751359664487; Tue, 01 Jul 2025
 01:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
 <20250629214449.14462-7-aleksandr.mikhalitsyn@canonical.com> <20250701-gehege-portrait-c098442c73d1@brauner>
In-Reply-To: <20250701-gehege-portrait-c098442c73d1@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 1 Jul 2025 10:47:31 +0200
X-Gm-Features: Ac12FXyvlb-oWVV4ZdKdWiFUglPTeWBh1qsmwVkifm-1RfJ3O1YjwqQVr7X_3U8
Message-ID: <CAEivzxfULsywKKuYM+T-5AMSQdF7ZyG85=PEJ0KZ0__j-B6=xw@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next 6/6] selftests: net: extend SCM_PIDFD test
 to cover stale pidfds
To: Christian Brauner <brauner@kernel.org>
Cc: kuniyu@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 9:59=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Jun 29, 2025 at 11:44:43PM +0200, Alexander Mikhalitsyn wrote:
> > Extend SCM_PIDFD test scenarios to also cover dead task's
> > pidfd retrieval and reading its exit info.
> >
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Luca Boccassi <bluca@debian.org>
> > Cc: David Rheinsberg <david@readahead.eu>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
>
> Thanks for the tests!
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks for off-list discussions/review and help too, Christian! ;-)

