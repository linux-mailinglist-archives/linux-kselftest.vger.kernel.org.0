Return-Path: <linux-kselftest+bounces-4678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728185552A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94E3B20DAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344CC13F006;
	Wed, 14 Feb 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KwJH+yRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2C139561
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947481; cv=none; b=mFWk+sx+dzmVxJ30yz25KBR2BDiSSu86mTB25tsrMOZ+Z8XSNdTcB3TL2NPZoX6GQ1/+xcchABSIOWYKgtgkaER80UqEdUbnTZ+TXo1YuGPfAOFozdsK5SZF6H4gS5FECA5/HUySN45Y2G4Y2j02d6t9nIW5xb/ODaGiOWXC7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947481; c=relaxed/simple;
	bh=XIUIsuylsJ2s0VEXAcTY/EhCiKZpllNlMEkfCfGawfw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Cnj02yXAMzJyJZz/kKPJTcIhLeXNcXdDQQa7c9fXmSBMLO5ZSJjZUpxwdLejAv+uIBXfgBriefuZeTXMju1Hcw5O/QO3ExTqdkuigIAPSo5B8cR5PC26/y8kgnB6LIm8xhhB9X3qfrq1GKDE1HcJSpYG6v8goKguT6oCdfampZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KwJH+yRR; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d094bc2244so2599251fa.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707947477; x=1708552277; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=nbi5t6r1KEtNuC1fJwyh+eduggjyreAriY+0UM+V9ow=;
        b=KwJH+yRRogZXsDcuEuw01Dv4s/88injKbXGXTmu6E4o+tJGRL4g4zA1kfIA/h0Nm3E
         9sSIqZjo+LyP/jF/dLIl5Cs6c8sOeQo0SwbzIEdbkYTsARmxlDd2gW2kbBJwQrZrYp/h
         P1IS6xZL3by2xht6eNS0BR/LIOgSJflx60gFnOB/oK2OFtUmhlR/tPk8lMcD5sHA6NOk
         0slnOGj7nl/Fb9k29vKvRK0YcZn4BqiOF/23SKTsbu1YX7kjO3aob/pqXd7xw6QyarBi
         MpZ5IwL1DTFVPRXAEWJsqJCx4JyQX5hqUhdcNPD1VaZPVl+AtorVGCJeRbFO4ozP0gIG
         bJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707947477; x=1708552277;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbi5t6r1KEtNuC1fJwyh+eduggjyreAriY+0UM+V9ow=;
        b=FwyEfNYmFdECkIkMgsIyOq+JmikMVVd8dBMD2JJGUvgLqaFt6R0T56ruyHMIiZsJhN
         a/1v9ushYQeFdISu+Nnth1PAbneJf/XrMD8Vh2p8KsWC4MDjarTj1Wevd1vQLI/KirK5
         PmoGiuSB0/7AnReYPdsRsC1pTCMtspWCa1EltllHUHVjVb8Xpj1CmwZYMczWMXJ0adrY
         xxZja5R5MIagMKTG1DUNc5m52dM3039Uy5za/k8So0G7wNsoBMLhXOeVciblwcP+9DJI
         NrVLEp8ZzgHN/uCS/duMe3rrgtaCI/KbNNlg6l71rERYBOvDXva1DVHZoMtNYYz641UW
         xcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSISWmzzJL5WaYV6dc9OeK1Z5rvwvJCozkoL0i49FPXV5zynh43ZAoWAGekuv2dGVZaQ0ucYr0clnfzp+I+9De8knN/1R72JMKFSzZPpcw
X-Gm-Message-State: AOJu0Ywks33r7Z3Qu7Wp3ftpzfrfAVOdI7aWOXx+r0Tqncb1rqi0ZXGw
	dRZmJI/YMYADwHRS/HSpfOpyHNFpcSdTVz63PCOdtOuT9HslvBcGrQQms1jhAyk=
X-Google-Smtp-Source: AGHT+IE422E09xZm07yxYe/pkl5wdut9RwVNqm65gSv3mkt8S05D8bGGZevMFlKYib1Nfth/nKoQeA==
X-Received: by 2002:a2e:9151:0:b0:2d0:fa5f:af60 with SMTP id q17-20020a2e9151000000b002d0fa5faf60mr2791966ljg.18.1707947477558;
        Wed, 14 Feb 2024 13:51:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKpu0+yYKrNR2taT0yKq+ixItlSRROEI58uzqY/cLEArTH/LHZYxZsskmoC8vdzmc++GMatmSxkFT3LLpppJB9PeDQFEbZpVautI0ih/Npa/Phl8OoGiQScpoQSTlpV+TCwSvRY9S8xOI+j99n+Amp3hpOraYxRRIYHwGC+Ms=
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1f2])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4949303edx.89.2024.02.14.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:51:16 -0800 (PST)
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-4-kuba@kernel.org> <87o7ciltgh.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, keescook@chromium.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests: kselftest_harness: support
 using xfail
Date: Wed, 14 Feb 2024 22:46:46 +0100
In-reply-to: <87o7ciltgh.fsf@cloudflare.com>
Message-ID: <87jzn6lnou.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 14, 2024 at 08:40 PM +01, Jakub Sitnicki wrote:

[...]

> On second thought, if I can suggest a follow up change so this:
>
> ok 17 # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
>
> ... becomes this
>
> ok 17 ip_local_port_range.ip4_stcp.late_bind # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
>
> You see, we parse test results if they are in TAP format. Lack of test
> name for xfail'ed and skip'ed tests makes it difficult to report in CI
> which subtest was it. Happy to contribute it, once this series gets
> applied.

Should have said "harder", not "difficult". That was an overstatement.

Test name can be extracted from diagnostic lines preceeding the status.

#  RUN           ip_local_port_range.ip4_stcp.late_bind ...
#      XFAIL      SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
#            OK  ip_local_port_range.ip4_stcp.late_bind
ok 17 ip_local_port_range.ip4_stcp.late_bind # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT

It just makes the TAP parser easier if the test name is included on the
status line. That would be the motivation here. Let me know what you
think.

[...]

