Return-Path: <linux-kselftest+bounces-33476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79BABFC6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A11BA7D5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794128982F;
	Wed, 21 May 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udt0r09S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EC13212A;
	Wed, 21 May 2025 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849292; cv=none; b=Ps/0g5ZK1km5fFaYb8hSfxvnkU3yEmUkd3XEabeB5qv2kLAF9R36wirKQoxkrFINuMiBrTjKhNL9zYdi7E0z19bYneXYaL54TbFRZrovShWonzIzzo+Z24l+q/m6/hukI5femT5zy0SeK4WL/ngAlERaYR6GWqxDXSvtDNzQJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849292; c=relaxed/simple;
	bh=Ci+15Ut7vakReKACvMX41F5pjZvsj8BXPIji9RDHSZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAPzQLH28laH+QXFQZ7Tad+3dQwpdeHrPsc7RuZz7J/mzcKl/43hMW5+GzeZ/RDIg7yRxoWG9kfGUGsjpGn4N80PUAq+Q5VbsdGyzby7ycjhX7TdjHMM4OFdy12Ug//o0rDy7kq5ly6+y7s3Y/lXODJVaqKAeTn8UickVZzTyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udt0r09S; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so5123903a12.0;
        Wed, 21 May 2025 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747849290; x=1748454090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QKJDy/G6dyf/3P2n06eSdhFgnhCjQFjz9zekSWtEPZ4=;
        b=Udt0r09SfLtg2pclZTuh7eGlMjr8Bn20UYRdEZ7ceR+iifRuW/+6XCROlmQ3/Rr4Q4
         knhuSYeMYte4CA+Qb9cUIRg51IrfZGwxs24/vnplQc2zmJAIdIEPS7n9r3Yo7LjyEzL6
         NcJPX+/IWPW6CijTyOJcCAnrIgIFUfQZCQzgcxbo9uoWJ2yL65zcw3cqtxmlY3odfDNv
         ZBDwOzBKeNTAOAtgqWP+pvyl7hRmUtV3VxViCNpYf6+5ARSs4B0HjDhfL/juoBH5YxSY
         /l9IRV+9xCD/a4l6lesY1y7xCYPOUZ0NtKG9O2O6wtZ3WTjzovErBQQt+vpjeEmvQwth
         tOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747849290; x=1748454090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKJDy/G6dyf/3P2n06eSdhFgnhCjQFjz9zekSWtEPZ4=;
        b=eYbd29vkY9aM8dcp/yalIme53TfS3A316JGYj7OP6Vh2O80yI1cN9Wd+WMdMYh8PE/
         tycjiMuUKHFccyyOfKXr2qtLBH7LgvcGnvjjfQGqkKzhJS0lVQt8QPSHga4ssPO4Ttp/
         A7KufkKwpm2/3SLrjk18MLEYUR3DByyX/uPT0KarbxwzNdSm7T9GKgaduNxFnWSOF6vi
         A4VR7T5qemJta5fDhQ+pYZZF+YTg7OKhjYLBMdLn8jyiX6/ghEdx645JRNT80Myd3o8S
         CeqbjeaARo6590fgJwzdyNlSc18iTkF+QNrUiKEg4kHt+FOOoOwTw4vwunuzH2V9jDHZ
         icNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcEwgC6yIwR2Pup9hp6eVW1gojuQJyFl3INw99w6l1MUXLGzsWlfANxezYjFQnRYK6+AvrOpoaMlPCXYQ=@vger.kernel.org, AJvYcCXLQUMcNGGm6KkecbynsgFFr1xCUcuGFgLpUDwvHz5Ad33eFCbhh6FeeSYUcfFLdssSfAGSz/W767VfFuaDbJUQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+10DXOl0AYv9WGB18DZEsUx9LZ2KatV4AL2HxHwr2CtncPGaC
	UfFKK66/otUysSXo944wvhBv7cRbkyROTYYuW1Ay51dwF0ae0QW6W6X/qheK
X-Gm-Gg: ASbGncuykfyWWTb5T1l520TtXcoSPqBIDqNg+ocj4pDjjZNS05CGda8Jqp1qO0u39Rs
	p6xdBY3yP1i6U0Pt/UY3wkEPoCPz+XaKP214x6iZ02BVK6LV0wh3UtTao1It3jz04zfd5kJm9QV
	wxufKoBY8zdePJShpO1nk8SPH3QSlOSJ4zJU/dncZVON8LNCi50p5JN+VSuP9HawU4dolluvZdQ
	NVzhfBLt37j9TB7eoegKlVh0PyFouTZdVyP3N3QyD+P2XjgMbQZQNcKufTjKFMSbFWQVImWB7aU
	D71LbwWawpFyuNj14eOMJceMDCOqRDCbzhUaObMGQxor+2FmuV3J+eqcFbhj0f1p2fv9I401IyC
	/16BfPPrmq1tS
X-Google-Smtp-Source: AGHT+IHIxyoDPLiCCkuQY+IowBN9/foca6U+VUTi63QjbG9PWpxj0135GJxA7UKNkm+WIMD0GA7Whg==
X-Received: by 2002:a17:903:1b6d:b0:223:f639:69df with SMTP id d9443c01a7336-231de3ba65amr350872475ad.41.1747849290457;
        Wed, 21 May 2025 10:41:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ac9619sm95324035ad.37.2025.05.21.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:41:30 -0700 (PDT)
Date: Wed, 21 May 2025 10:41:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	sagi@grimberg.me, willemb@google.com, asml.silence@gmail.com,
	jdamato@fastly.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: ncdevmem: add tx test with
 multiple IOVs
Message-ID: <aC4QSV1OFNtodw9Y@mini-arch>
References: <20250520203044.2689904-1-stfomichev@gmail.com>
 <20250520203044.2689904-3-stfomichev@gmail.com>
 <CAHS8izMEaPUDnoQaYTaTMY719FJ_-Rb-Ui7ika_yZGQ70VWiVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMEaPUDnoQaYTaTMY719FJ_-Rb-Ui7ika_yZGQ70VWiVQ@mail.gmail.com>

On 05/21, Mina Almasry wrote:
> On Tue, May 20, 2025 at 1:30 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > Use prime 3 for length to make offset slowly drift away.
> >
> > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > ---
> >  .../testing/selftests/drivers/net/hw/devmem.py  | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> > index 7fc686cf47a2..d7f6a76eb2b7 100755
> > --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > @@ -49,12 +49,27 @@ from lib.py import ksft_disruptive
> >      ksft_eq(socat.stdout.strip(), "hello\nworld")
> >
> >
> > +@ksft_disruptive
> > +def check_tx_chunks(cfg) -> None:
> > +    cfg.require_ipver("6")
> > +    require_devmem(cfg)
> > +
> > +    port = rand_port()
> > +    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
> > +
> > +    with bkg(listen_cmd, exit_wait=True) as socat:
> > +        wait_port_listen(port)
> > +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port} -z 3", host=cfg.remote, shell=True)
> > +
> > +    ksft_eq(socat.stdout.strip(), "hello\nworld")
> > +
> > +
> >  def main() -> None:
> >      with NetDrvEpEnv(__file__) as cfg:
> >          cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
> >          cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
> >
> > -        ksft_run([check_rx, check_tx],
> > +        ksft_run([check_rx, check_tx, check_tx_chunks],
> >                   args=(cfg, ))
> >      ksft_exit()
> >
> > --
> > 2.49.0
> >
> 
> I was hoping we'd add the test coverage without the need to add test
> cases to the ksft. I was thinking maybe ncdevmem can do rand() each
> sendmsg loop and send a different set of chunks, so that we don't need
> a flag.
> 
> But it may be too hacky to have the test be non-deterministic, so up to you
> 
> Acked-by: Mina Almasry <almasrymina@google.com>

Thanks! Let's spell it out explicitly for now. Doing it at random seems
like an option when we start sending more data (after your series
that converts the tests to -v).

