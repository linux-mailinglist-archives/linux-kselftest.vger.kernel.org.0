Return-Path: <linux-kselftest+bounces-21709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9ED9C24D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 19:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC432832B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E962193418;
	Fri,  8 Nov 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNJXERGQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD43233D60;
	Fri,  8 Nov 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090125; cv=none; b=fIQz4q6SX/wBKtMsnp6I5uC/6E9Qu29M/VbhrYNT2on+ZlKoDA7/ai1sBHLEepu6fWM30d2aP/CMk9pV6MrtgkdbAQRMq/zHpHLX9YYQq86j2d3bZBQ80zSv3BzaX9BhiSq/T2g269cgGCFwlp6u9zkWO8zV7RUWG8x1RFp1Ka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090125; c=relaxed/simple;
	bh=uSbhMMNXHlsMSzCdJptCATaZ8Ww+L2KbwXDPpWyMELc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nzFe4JCV18xYH+0EBnK0nO35QuI8tATJ0HI8rMrQhrwgNogS1AH56CVae21UdMfCOr4naclqJ5wYY4zXxvEQBbEk3H7Lp+2Ui8SaaoRveLrmtVEQqYYW8NnWrtlj+yTEfdHlnamQrNUt0GtS2LkQ2QcTyw9Yawm9zmrqgafclVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNJXERGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04088C4CECD;
	Fri,  8 Nov 2024 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731090124;
	bh=uSbhMMNXHlsMSzCdJptCATaZ8Ww+L2KbwXDPpWyMELc=;
	h=Date:To:Cc:From:Subject:From;
	b=BNJXERGQde9LzwMDtEYyxf4jQdMXY4FLQADYMkmnjpB/woYao/4OInEPnzSDezJxQ
	 Q1NUbA6L6RVsVEiiQs48N2P9OYJN9oAf6+DZXwDybyvLX6TN6YZ06CJOje8bNfsS1b
	 LUc7AtFr3JHDxVI3HnDGBuSnuZ/wZXpcf2BR8pHR9/lOhN7vupLtQEqkOBkNWbKd/M
	 kviLEMcOkF7bY1xwd0litkU7qQe7qfnLB5CYFxNY5cDHHmWm3Q5xiyKfhFka16p2vt
	 9LkbHeXlCRGMGxhC+CcMuAgOr7TnswGBg6xGLoQ0bNRyhDCuvuYQlMppGQ4KwhpH8h
	 t4xXzhYeOPE9A==
Message-ID: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>
Date: Fri, 8 Nov 2024 19:21:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: Linux Kernel Functional Testing <lkft@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Kernel Selftests <linux-kselftest@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, Linux Kernel
 <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Ido Schimmel
 <idosch@nvidia.com>, stable@vger.kernel.org
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Subject: LKFT CI: improving Networking selftests results when validating
 stable kernels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello LKFT maintainers, CI operators,

First, I would like to say thank you to the people behind the LKFT
project for validating stable kernels (and more), and including some
Network selftests in their tests suites.

A lot of improvements around the networking kselftests have been done
this year. At the last Netconf [1], we discussed how these tests were
validated on stable kernels from CIs like the LKFT one, and we have some
suggestions to improve the situation.


KSelftests from the same version
--------------------------------

According to the doc [2], kselftests should support all previous kernel
versions. The LKFT CI is then using the kselftests from the last stable
release to validate all stable versions. Even if there are good reasons
to do that, we would like to ask for an opt-out for this policy for the
networking tests: this is hard to maintain with the increased
complexity, hard to validate on all stable kernels before applying
patches, and hard to put in place in some situations. As a result, many
tests are failing on older kernels, and it looks like it is a lot of
work to support older kernels, and to maintain this.

Many networking tests are validating the internal behaviour that is not
exposed to the userspace. A typical example: some tests look at the raw
packets being exchanged during a test, and this behaviour can change
without modifying how the userspace is interacting with the kernel. The
kernel could expose capabilities, but that's not something that seems
natural to put in place for internal behaviours that are not exposed to
end users. Maybe workarounds could be used, e.g. looking at kernel
symbols, etc. Nut that doesn't always work, increase the complexity, and
often "false positive" issue will be noticed only after a patch hits
stable, and will cause a bunch of tests to be ignored.

Regarding fixes, ideally they will come with a new or modified test that
can also be backported. So the coverage can continue to grow in stable
versions too.

Do you think that from the kernel v6.12 (or before?), the LKFT CI could
run the networking kselftests from the version that is being validated,
and not from a newer one? So validating the selftests from v6.12.1 on a
v6.12.1, and not the ones from a future v6.16.y on a v6.12.42.


Skipped tests
-------------

It looks like many tests are skipped:

- Some have been in a skip file [3] for a while: maybe they can be removed?

- Some are skipped because of missing tools: maybe they can be added?
e.g. iputils, tshark, ipv6toolkit, etc.

- Some tests are in 'net', but in subdirectories, and hence not tested,
e.g. forwarding, packetdrill, netfilter, tcp_ao. Could they be tested too?

How can we change this to increase the code coverage using existing tests?


KVM
---

It looks like different VMs are being used to execute the different
tests. Do these VMs benefit from any accelerations like KVM? If not,
some tests might fail because the environment is too slow.

The KSFT_MACHINE_SLOW=yes env var can be set to increase some
tolerances, timeout or to skip some parts, but that might not be enough
for some tests.


Notifications
-------------

In case of new regressions, who is being notified? Are the people from
the MAINTAINERS file, and linked to the corresponding selftests being
notified or do they need to do the monitoring on their side?


Looking forward to improving the networking selftests results when
validating stable kernels!


[1] https://netdev.bots.linux.dev/netconf/2024/
[2] https://docs.kernel.org/dev-tools/kselftest.html
[3]
https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/skipfile-lkft.yaml

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


