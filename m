Return-Path: <linux-kselftest+bounces-8826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847598B16FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 01:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B592F1C2418C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B046A15747E;
	Wed, 24 Apr 2024 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qBLMYbIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6E16EBEF
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000794; cv=none; b=FJAlfl1QUndDEmNYP7J6anse+Yh8aHURZ7vDBiTObCFHJT7OQzeKRP30zP/UjiClLMN+p8oQ3KYk84Py869O8z5LDNQwR52OdMQmhhcpRfhkzRbHt+Bp701tWpn7M70/6iczuM24H5XNuE7FDDri89PYH1xKnPKco2O5YjE/4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000794; c=relaxed/simple;
	bh=z4ViiZLxdy4jCZuWPQrDKXZVk0No4/qeBTQCDlNgGvQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t8URSLrfWMb7c1u1C1OwVR2yM5o8yRgM57rS0tVfZ4ek6FYpdjRNO9IUkd6iwBA5i9ZBKRfm3Rr503ibmwS7xS90rgNMe5t0CtT/3urwwV9PrX4PVOyze7gZbT97hoTz9KJyIelHlsZC+Lhg1RIWfXlj6Mz8F14qOUjkb7fuF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qBLMYbIM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso3291575ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714000792; x=1714605592; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUTRfOJXq9toeuTA94eYM/KVw4rlaWe4u/+EWKtDEug=;
        b=qBLMYbIMnIgOi/RtSlLiyEuaSN27DHEDMv+dnOyra2GH2ZpNDqxON+4Khga8LZ1oEq
         R+40X9Peh9P6mzDQO9/bGKCf0rGAIP6U79U1YqBJ56KWYa7qe7jC41T0dRxPN4JlTpiT
         m1aMbs9QRt5kEruUTQ9sGUMIPQ4+0U9Y16OSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000792; x=1714605592;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUTRfOJXq9toeuTA94eYM/KVw4rlaWe4u/+EWKtDEug=;
        b=tJl++n7SYS612whQKfr0IXnnYpR5XABVK+KQ0lNh+yb6TVpc2bhOx15FMWDocrjeIP
         4+UtjGqn6jmERm51tfaDzS2/8hZUm27kzZLCWWKsMe98eFhfbiW6tybsEAXyJFAx+2On
         VQlN5IClfFxFdUhAUOI9JldCMKuJuz+QX0oyhdHV5k8xMgWlBfnIDPjTEv3jLnmURZ6B
         +Y2uMGsC2BCl/m0d3GyFc70j4OICzjllaO5j8OjY47M2n76XQc13iIdphQKy3TwUCdG1
         7Rr3hKgZb/MZPsP0jtiaPHjPJl9wTucB8zr8CbzR0ygoY0dctkYuFV+/OR95dHhos5k4
         0lHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIVYeVJom1cJCOYOMJkv6w5U4Dld8GkbSYemzcMKQ9TCO/pVCHQBwoz+zGmkwh1hTHOODO0y0CMmi7oNPZAaK6PRT/fMxKRNPCJoranc8O
X-Gm-Message-State: AOJu0YxQbXy+tKtR8xa55Np7N7ooldhBkElw/wqfEawyk6r2i6OPNzAS
	3kpSDGZo30ai80dcpnrpoZlvGNjz+8/a+YJ6RLFuGkWbY2aTrUf+omaxF7nDF2Q=
X-Google-Smtp-Source: AGHT+IFkRA0EgSkYjbg6bSMkqdrLpRXRjpOUupwLvqO6F0KMMqDuOjofX2sPeF9mvRaeqlL+TXudrA==
X-Received: by 2002:a17:902:d481:b0:1e8:d85a:970 with SMTP id c1-20020a170902d48100b001e8d85a0970mr5004577plg.10.1714000792243;
        Wed, 24 Apr 2024 16:19:52 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001dd2bacf30asm12539301plg.162.2024.04.24.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:19:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:19:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, shuah@kernel.org
Subject: ynl: maybe minor bug?
Message-ID: <ZimTlf_ISC2n8snQ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there:

I am probably just doing something wrong, but I tried to run
tools/testing/selftests/drivers/net/stats.py today and hit what is possibly
a bug?

Background info: Python 3.12.3

I'm using net-next at commit 9dd15d5088e9 ("Merge branch
'sparx5-port-mirroring'") with a couple driver modifications added on top
of it that don't seem relevant to the two test failures I'm hitting:

1. "loopback has no stats", and
2. "Try to get stats for lowest unused ifindex but not 0"

Both of these tests expect the ynl library to raise an exception, but I
don't think it does, from tools/net/ynl/lib/ynl.py, the _ops method:

  if nl_msg.error:
      raise NlError(nl_msg)
  if nl_msg.done:
      if nl_msg.extack:
          print("Netlink warning:")
          print(nl_msg)

And the code in net/core/netdev-genl.c seems to set:

 else {
        NL_SET_BAD_ATTR(info->extack,
                        info->attrs[NETDEV_A_QSTATS_IFINDEX]);
        err = netdev ? -EOPNOTSUPP : -ENODEV;

which is what cli.py says:

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"ifindex": "1"}'
Netlink warning:
nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
	extack: {'bad-attr': '.ifindex'}
[]

that seems to be the warning print out from the above
tools/net/ynl/lib/ynl.py snippet, not an NlError, which is what you'd get
if you tried ifindex 0 (which is listed as out of range in the YAML spec):

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"ifindex": "0"}'

Netlink error: Numerical result out of range
nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
	error: -34
        extack: {'msg': 'integer out of range', 'policy': {'min-value': 1,
        'max-value': 4294967295, 'type': 'u32'}, 'bad-attr': '.ifindex'}

I'm not sure whether:

1. tools/net/ynl/lib/ynl.py should be raising NlError when there is an
   extack in this case (I think this is probably the way to go?), or

2. the tests should be changed so that they don't expect an exception to be
   raised but (ideally?) hide the warning report from tools/net/ynl/lib/ynl.py
   when the warning is expected.

I don't know python at all so this is definitely wrong, but here's a small
change I made to fix the test (a similar change was made for the test which
follows).

The following patch is not intended to be seriously considered for
application, just to highlight the issue I am hitting:

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 7a7b16b180e2..d9f5d1f3ed34 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -115,9 +115,8 @@ def qstat_by_ifindex(cfg) -> None:
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')

     # loopback has no stats
-    with ksft_raises(NlError) as cm:
-        netfam.qstats_get({"ifindex": 1}, dump=True)
-    ksft_eq(cm.exception.nl_msg.error, -95)
+    stats = netfam.qstats_get({"ifindex": 1}, dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -34)
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')



Thanks,
Joe

