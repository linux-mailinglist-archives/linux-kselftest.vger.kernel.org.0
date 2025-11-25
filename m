Return-Path: <linux-kselftest+bounces-46451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC414C85DCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 17:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49048350C57
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84B21D5AA;
	Tue, 25 Nov 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKJm/w5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9491F471F
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086697; cv=none; b=WhJ70FrmtKkhsliDED8bd0hdPM8UPtjdoiv/dMXibk0io64o3MXy+AlqllNWtUjWT8x1dfY4mXvZvPg6IrhuHuxDUIuZ4HnF4vK54Bu4hirHMsDshVgZiuGGLAUlh+NKRcri8Crwt23qH41cra4JxRdURZNyXmcu0hCBTGwNI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086697; c=relaxed/simple;
	bh=UyyByTuY+3Pmfua0Po9WTijBQVKNAcXITMdPGJvxnzo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g1oZC0pDZyIhjYkGddCigYlGL4HMEO9t67OjBduMKODpvnQ5O2uJrrKKp8s77CRKq9iNCdcGC/MTEc4KOjr3oTGXHj0NKx30prHcJFWgB0CNOv6H0sH8YLADsK6+Jvskf6TxxKKfTUwxg/77rmMOaZ9kmVgQ3YNeBzDwQ7pKM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKJm/w5h; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e19642764so4212567d50.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764086695; x=1764691495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufovA9njBrcJJicKUMIOkwxg5WNvQhR6uFRYNHpjveE=;
        b=gKJm/w5h8yNPbxByrDZvgfL6xjepOPMj/BlbvNPP4E/bWLms3gJvF+2EARCsHcjpfp
         mDPqeeeiO/VJS3ZU5WUx9/nMwznv0d/9pNdjNE3EOrFPONpjEBPSiXXLCeS+hUc4ujCi
         AvxjDbfYI+H4LUf5jKvpHhzaYZsjW0OXL3dRSWn9YoaKWKRYih0+UsWMDdhAQq4BcY0r
         +XNj59OkYcNYMcNfO3sPpmZMWJ8hUsqJ9HV6r7HSoWFcUD0/JmWvRIpvhDBg9UJR19Ai
         gqjLvd47/NbKWRGbW6Mvk4MXQ0ldOcEcPeGbVMZMvt/uslp/3vyL4oJq4uRhg7DkjQ9V
         ZtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764086695; x=1764691495;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufovA9njBrcJJicKUMIOkwxg5WNvQhR6uFRYNHpjveE=;
        b=qmOYIevEPJQOenaCXpHhz3C6P3v0B5Sf34Bkr3AGegU56JzgSfcv87zFekwLJSyMbc
         Gpay2GSMHlDFhO6HL7KbPaybtF5j2DfNWV6fZES1fMGY9SNkh+lu871M9bkKoUpz96zT
         jTo+LPd4TwiN1AcxxH7yxcYjkKUfk29qPWob4ueDDSr5yNct5TcE/W51aWJghrBcKuw2
         GJ9gdJ1rNstrGqcPSdPY/072iDK6YY5WttMra2zw4yXKoOdih2PtCRrVXbCPWX/qmzNn
         Nlrcu/mZMiiezT2c6TlIXZOg5RhxKzD0bAP2mU01txodGuy7I4JfVl7y/g3DDD+x9ESc
         X06Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmH+E80OTj0VN+fujK3lNBI8HiKhj8WEdMIP2eSxVDTYPbGkB8bpG6COPz2DQwboauNadY8ZuAy7E2zYiJNXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFAWurM2Z85a9kc+75x0my44dJW4jpDkqaRY79okvQ6opFO1T
	A/FZm2KHmDKYMfXov3U3xF3yUbLzEGD//qEqEaG59IpC1S3f0WzR9mHX
X-Gm-Gg: ASbGnctdDEYRmOkYpv8XhaTvCJzq0i166OdG99R2kHV5LtsVBFKQOaeu+nNAWkiWk6X
	VVeAFJvUZvcSuAwHw7lDSR7JpCxTf3SEDnax4s9j6Sb3qiTZxmBW+ZdMh3laDLoe5utg/t7nB50
	COauxTnpIRiTG8IAuvelHeXlqP2uBqtKqxXeywlquz2i3ldUwc/KAz7HGCgMOeioGXynu3ct4D6
	sI92VqBD0UJgiCyPuAtmHTZviUPw+Jl+y+fEPhWSlbmTrc6l9R8MjS3jf0Eb6DK08uMBe4rBJas
	cDWtbAXD3uxaEZHZZnPzBmfOP8oTIKhEVxSzOEDp9taIS6K5Wi6/BU2PAnBKvdCjLAQbx2eQEZm
	zNp2+gtk5Ls2RqarwuWZ2K/5UOSt+9BUAHNlMOZ9hqka3sbe8fyevW2+IHmG6Tv14+0gFCgqwnv
	dBXWjMC7WiSqQDCr4rqyUSsdc07Z4e92wHPJJm667oAny6QHJelMsrurA8mkImazUohHs=
X-Google-Smtp-Source: AGHT+IFMsVqQio40MqwigTpnntui9rbl+ng5ZfDUQwZJ043z1MBQaQ5WaAyam/USMadKLWIPTN7vBA==
X-Received: by 2002:a05:690e:214c:b0:63f:a06e:9a7d with SMTP id 956f58d0204a3-64302ad9f66mr8502542d50.64.1764086695379;
        Tue, 25 Nov 2025 08:04:55 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798a77d0sm56497707b3.22.2025.11.25.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:04:54 -0800 (PST)
Date: Tue, 25 Nov 2025 11:04:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.10c7edf4c3dd1@gmail.com>
In-Reply-To: <aSUxhmqXmIPSdbHm@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
 <willemdebruijn.kernel.1e69bae6de428@gmail.com>
 <aSUxhmqXmIPSdbHm@fedora>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ankit Khushwaha wrote:
> On Mon, Nov 24, 2025 at 01:15:33PM -0500, Willem de Bruijn wrote:
> > This does not reproduce for me.
> > 
> > Can you share the full clang command that V=1 outputs, as well as the
> > output oof clang --version.
> 
> Hi Willem,
> I have added clang output in 
> https://gist.github.com/ankitkhushwaha/8e93e3d37917b3571a7ce0e9c9806f18
> 
> Thanks,
> Ankit

I see. This is with clang-21. It did not trigger for me with clang-19.

I was able to reproduce with Ubuntu 25.10.

Okay, good to suppress these false positives with normal builds.

Reviewed-by: Willem de Bruijn <willemb@google.com>


