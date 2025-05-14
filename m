Return-Path: <linux-kselftest+bounces-32932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E2AB67F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425931884C33
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277925D532;
	Wed, 14 May 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OwuZWZ5l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C9225401;
	Wed, 14 May 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216158; cv=none; b=m6I/Y+nAvjPIfTyo7IVWLXnW+OG8UQKC3gc7XI9HRAYc63LRA7c6pJ4NJmzffQOUnpEUNladzOWylzNd6LRO2cc0V9v5iioCofaRshEDke+M/YgYdMFodq2ktd/U0+TmgUEkIqKDWSeH14jEfzuvuoEd18Ajq2vYY84Bbxd3fMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216158; c=relaxed/simple;
	bh=I/xfkx4oS+CO+iJTCXpNZil3HZkdHTcfmmZldcmLEWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUceLduvs8SJM2nAzFH6Pq304fXvzryOJYTCGR+EfNXFjAdXPb15D5npANGXQzWy/TCTV9U6gcKDde1QxbhJ8BH9YVWpsGTB2XW9PjIYnD4+5Q6KB0NbnxUtJTfaaE4uCRnjGb4faKvPwlCuAOIl8FDmuteF+d8b3BcdLnOrAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OwuZWZ5l; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by smtp.orange.fr with ESMTPA
	id F8iWurrLLKbq8F8iWu0KP2; Wed, 14 May 2025 11:48:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747216080;
	bh=ZBP0uJzd56VrQnu3aZWTVRlZkiQI89jFmo2wAt9/3+E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=OwuZWZ5l5ZvbLhLhXTJIeUDInOBSzd8Unb+dQ3Xv/Pa7fRJImL1iRsGkIZ4pKW+4D
	 tyR/T9Cil2TGm0fiEE5Iz5DeDCGFcFMkQgGUVeodAe91yHP3Ccx1oer8sofduRFtNU
	 7uVUwukCyy/n+B/JUzwkvcshPqq3ce+LJ/paG+3vvUPTr/1Ccfao03ynJEFwjOapM8
	 hbbKXsQPC0P6NpZ1gSh7fj0JFZ8RqxIiTZwNNUlJCt5y3UdjRZIWzYMkWhAXFtey/W
	 lBPDO7MJKUjHVtRnrbaOM6llbDsLr584Tg5g7+cQRALJeNd94a2P94ytc9xWCSp6TD
	 w5BUrLZ4xI/2A==
X-ME-Helo: mail-ed1-f54.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 May 2025 11:48:00 +0200
X-ME-IP: 209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso12046472a12.0;
        Wed, 14 May 2025 02:48:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzxGkiMpqvEC/ia41Yv71nQ5aPVqn2uiAzn5gXjcuTLDZ+k7/FKnWtyLWEpF5wbrckiKzfu84vZBI=@vger.kernel.org, AJvYcCXMujoQi8UtAF4BL1M+FsWyXgn78ps2jQiGuZT7luNcxq8QI0eU4ffnoyFerXLgohsV0bSEuL9i@vger.kernel.org, AJvYcCXdYLLdkkXiBbPIc4Jw774UQVQmvC4xgbZYfq7fQ/+vT+D08zhJ17pnXW9hW06s+1toA2TUexvkb/MSU/mSjRzh@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrvmSYZZMo/KrvwGQ3ZT1ejLEUC1pk0vfyq6W4mwqbq6sk8Oh
	EG4tM+pCzJL6wurRH7F6A4OeBsO3A2YS8vOWxLJOteAk4hAN0B3SU0NT07NZnibyDs69l19uowp
	4aJ+JUsMiLXRy656HKB8AJt8Zmoo=
X-Google-Smtp-Source: AGHT+IHdkZu6iv4c3J/aBkRakfFe6fqX/yAz3rS/y9MPMO55DTmmrQSki2I21b4UB82YVuKr4bxtbUgPHKfMJsyjfxA=
X-Received: by 2002:a17:907:8947:b0:ad2:59c4:9d with SMTP id
 a640c23a62f3a-ad4f7292ce5mr232669466b.38.1747216080094; Wed, 14 May 2025
 02:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dac10156eb550871c267bdfe199943e12610730b.1746801747.git.fmaurer@redhat.com>
In-Reply-To: <dac10156eb550871c267bdfe199943e12610730b.1746801747.git.fmaurer@redhat.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Wed, 14 May 2025 18:47:47 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKmPD+BZkVC1C-vn7hcAVdQr8Qhd6PW8bASZiQkD6MV-A@mail.gmail.com>
X-Gm-Features: AX0GCFvcj_f1A4VN1Q0El4CYnrgR6FNHTCln1tNBvjoBedgb8hFH2spjQ1FwhA8
Message-ID: <CAMZ6RqKmPD+BZkVC1C-vn7hcAVdQr8Qhd6PW8bASZiQkD6MV-A@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: can: Import tst-filter from can-tests
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Felix,

On Sat. 10 May 2025 at 00:07, Felix Maurer <fmaurer@redhat.com> wrote:
> Tests for the can subsystem have been in the can-tests repository[1] so
> far. Start moving the tests to kernel selftests by importing the current
> tst-filter test. The test is now named test_raw_filter and is substantially
> updated to be more aligned with the kernel selftests, follow the coding
> style, and simplify the validation of received CAN frames. We also include
> documentation of the test design. The test verifies that the single filters
> on raw CAN sockets work as expected.
>
> We intend to import more tests from can-tests and add additional test cases
> in the future. The goal of moving the CAN selftests into the tree is to
> align the tests more closely with the kernel, improve testing of CAN in
> general, and to simplify running the tests automatically in the various
> kernel CI systems.
>
> [1]: https://github.com/linux-can/can-tests
>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

Thanks again.

I left a set of nitpicks, I expect to give my reviewed-by tag on the
next version.

> ---
>
> Notes:
>     I keep netdev and its reviewers and maintainers in CC because of the
>     changes to their paths in MAINTAINERS, even though Jakub acked them on
>     v1. The change should be merged through linux-can-next and subsequent
>     changes will not go to netdev anymore.
>
>     I have removed the long form of the licenses in the beginning of the
>     file during the import, as that is covered by the SPDX line anyways. The
>     copyright is left as it was originally.

Ack.

>     Changes to v1:
>     - link: https://lore.kernel.org/linux-can/cover.1745323279.git.fmaurer@redhat.com/
>     - Squashed import and rewrite into a single commit
>     - Simplified checking of the received flags
>     - Pass the interface name through env (easier with the selftest
>       framework than adding an argument)
>
>     I have not updated test_raw_filter.sh to work with physical CAN
>     interfaces so far because I don't have one to test this right now and
>     don't think it's a priority for selftests for now.

OK but can you just:

  s/VCANIF/CANIF/g

in the .sh and in the .c files? This way, when the test gets updated
to also support the physical interfaces, the patch diff will be
smaller.

I have the hardware, so it is something I can easily contribute.

>  MAINTAINERS                                   |   2 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/net/can/.gitignore    |   2 +
>  tools/testing/selftests/net/can/Makefile      |  11 +
>  .../selftests/net/can/test_raw_filter.c       | 395 ++++++++++++++++++
>  .../selftests/net/can/test_raw_filter.sh      |  37 ++
>  6 files changed, 448 insertions(+)
>  create mode 100644 tools/testing/selftests/net/can/.gitignore
>  create mode 100644 tools/testing/selftests/net/can/Makefile
>  create mode 100644 tools/testing/selftests/net/can/test_raw_filter.c
>  create mode 100755 tools/testing/selftests/net/can/test_raw_filter.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 241ca9e260a2..55749b492ebb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5155,6 +5155,7 @@ F:        include/uapi/linux/can/isotp.h
>  F:     include/uapi/linux/can/raw.h
>  F:     net/can/
>  F:     net/sched/em_canid.c
> +F:     tools/testing/selftests/net/can/
>
>  CAN-J1939 NETWORK LAYER
>  M:     Robin van der Gracht <robin@protonic.nl>
> @@ -16577,6 +16578,7 @@ X:      net/ceph/
>  X:     net/mac80211/
>  X:     net/rfkill/
>  X:     net/wireless/
> +X:     tools/testing/selftests/net/can/
>
>  NETWORKING [IPSEC]
>  M:     Steffen Klassert <steffen.klassert@secunet.com>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 8daac70c2f9d..e5c9ecd52b73 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -64,6 +64,7 @@ TARGETS += mqueue
>  TARGETS += nci
>  TARGETS += net
>  TARGETS += net/af_unix
> +TARGETS += net/can
>  TARGETS += net/forwarding
>  TARGETS += net/hsr
>  TARGETS += net/mptcp
> diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
> new file mode 100644
> index 000000000000..764a53fc837f
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +test_raw_filter
> diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
> new file mode 100644
> index 000000000000..5b82e60a03e7
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +top_srcdir = ../../../../..
> +
> +CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +
> +TEST_PROGS := test_raw_filter.sh
> +
> +TEST_GEN_FILES := test_raw_filter
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
> new file mode 100644
> index 000000000000..3c0e43cab1e8
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2011 Volkswagen Group Electronic Research
> + * All rights reserved.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +#include <sys/time.h>
> +#include <net/if.h>
> +#include <linux/if.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/raw.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define ID 0x123
> +
> +char VCANIF[IFNAMSIZ];
> +
> +static int send_can_frames(int sock, int testcase)
> +{
> +       struct can_frame frame;
> +
> +       frame.can_dlc = 1;
> +       frame.data[0] = testcase;
> +
> +       frame.can_id = ID;
> +       if (write(sock, &frame, sizeof(frame)) < 0)
> +               goto write_err;
> +
> +       frame.can_id = (ID | CAN_RTR_FLAG);
> +       if (write(sock, &frame, sizeof(frame)) < 0)
> +               goto write_err;
> +
> +       frame.can_id = (ID | CAN_EFF_FLAG);
> +       if (write(sock, &frame, sizeof(frame)) < 0)
> +               goto write_err;
> +
> +       frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
> +       if (write(sock, &frame, sizeof(frame)) < 0)
> +               goto write_err;
> +
> +       return 0;
> +
> +write_err:
> +       perror("write");
> +       return 1;
> +

Nitpick: remove the empty line.

> +}
> +
> +FIXTURE(can_filters) {
> +       int sock;
> +};
> +
> +FIXTURE_SETUP(can_filters)
> +{
> +       struct sockaddr_can addr;
> +       struct ifreq ifr;
> +       int recv_own_msgs = 1;
> +       int s, ret;
> +
> +       s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
> +       ASSERT_LT(0, s)

0 is a valid fd (OK it is used for the stout, so your code will work,
but the comparison still looks unnatural).

What about:

  ASSERT_NE(s, -1)

or:

  ASSERT_GE(s, 0)

?

(same comment for the other ASSERT_LE)

> +               TH_LOG("failed to create CAN_RAW socket: %d", errno);
> +
> +       strncpy(ifr.ifr_name, VCANIF, sizeof(ifr.ifr_name));
> +       ret = ioctl(s, SIOCGIFINDEX, &ifr);
> +       ASSERT_LE(0, ret)
> +               TH_LOG("failed SIOCGIFINDEX: %d", errno);
> +
> +       addr.can_family = AF_CAN;
> +       addr.can_ifindex = ifr.ifr_ifindex;
> +
> +       setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
> +                  &recv_own_msgs, sizeof(recv_own_msgs));
> +
> +       ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
> +       ASSERT_EQ(0, ret)
> +               TH_LOG("failed bind socket: %d", errno);
> +
> +       self->sock = s;
> +}
> +
> +FIXTURE_TEARDOWN(can_filters)
> +{
> +       close(self->sock);
> +}
> +
> +FIXTURE_VARIANT(can_filters) {
> +       int testcase;
> +       canid_t id;
> +       canid_t mask;
> +       int exp_num_rx;
> +       canid_t exp_flags[];
> +};
> +#define T_EFF (CAN_EFF_FLAG >> 28)
> +#define T_RTR (CAN_RTR_FLAG >> 28)

These two macros are not needed anymore and can be removed.

> +/* Receive all frames when filtering for the ID in standard frame format */
> +FIXTURE_VARIANT_ADD(can_filters, base) {
> +       .testcase = 1,
> +       .id = ID,
> +       .mask = CAN_SFF_MASK,
> +       .exp_num_rx = 4,
> +       .exp_flags = {
> +               0,
> +               CAN_RTR_FLAG,
> +               CAN_EFF_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +/* Ignore EFF flag in filter ID if not covered by filter mask */
> +FIXTURE_VARIANT_ADD(can_filters, base_eff) {
> +       .testcase = 2,
> +       .id = ID | CAN_EFF_FLAG,
> +       .mask = CAN_SFF_MASK,
> +       .exp_num_rx = 4,
> +       .exp_flags = {
> +               0,
> +               CAN_RTR_FLAG,
> +               CAN_EFF_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +/* Ignore RTR flag in filter ID if not covered by filter mask */
> +FIXTURE_VARIANT_ADD(can_filters, base_rtr) {
> +       .testcase = 3,
> +       .id = ID | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK,
> +       .exp_num_rx = 4,
> +       .exp_flags = {
> +               0,
> +               CAN_RTR_FLAG,
> +               CAN_EFF_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +/* Ignore EFF and RTR flags in filter ID if not covered by filter mask */
> +FIXTURE_VARIANT_ADD(can_filters, base_effrtr) {
> +       .testcase = 4,
> +       .id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK,
> +       .exp_num_rx = 4,
> +       .exp_flags = {
> +               0,
> +               CAN_RTR_FLAG,
> +               CAN_EFF_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +
> +/* Receive only SFF frames when expecting no EFF flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_eff) {
> +       .testcase = 5,
> +       .id = ID,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               0,
> +               CAN_RTR_FLAG,
> +       },
> +};
> +/* Receive only EFF frames when filter id and filter mask include EFF flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_eff_eff) {
> +       .testcase = 6,
> +       .id = ID | CAN_EFF_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               CAN_EFF_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +/* Receive only SFF frames when expecting no EFF flag, ignoring RTR flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_eff_rtr) {
> +       .testcase = 7,
> +       .id = ID | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               0,
> +               CAN_RTR_FLAG,
> +       },
> +};
> +/* Receive only EFF frames when filter id and filter mask include EFF flag,
> + * ignoring RTR flag
> + */
> +FIXTURE_VARIANT_ADD(can_filters, filter_eff_effrtr) {
> +       .testcase = 8,
> +       .id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               CAN_EFF_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +
> +/* Receive no remote frames when filtering for no RTR flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_rtr) {
> +       .testcase = 9,
> +       .id = ID,
> +       .mask = CAN_SFF_MASK | CAN_RTR_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               0,
> +               CAN_EFF_FLAG,
> +       },
> +};

Nitpick: sometimes you have an empty line between the fixtures,
sometimes you don't. Can you rationalize this and always have an empty
new line between the fixtures?

> +/* Receive no remote frames when filtering for no RTR flag, ignoring EFF flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_rtr_eff) {
> +       .testcase = 10,
> +       .id = ID | CAN_EFF_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_RTR_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               0,
> +               CAN_EFF_FLAG,
> +       },
> +};
> +/* Receive only remote frames when filter includes RTR flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_rtr_rtr) {
> +       .testcase = 11,
> +       .id = ID | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_RTR_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               CAN_RTR_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +/* Receive only remote frames when filter includes RTR flag, ignoring EFF
> + * flag
> + */
> +FIXTURE_VARIANT_ADD(can_filters, filter_rtr_effrtr) {
> +       .testcase = 12,
> +       .id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_RTR_FLAG,
> +       .exp_num_rx = 2,
> +       .exp_flags = {
> +               CAN_RTR_FLAG,
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +
> +/* Receive only SFF data frame when filtering for no flags */
> +FIXTURE_VARIANT_ADD(can_filters, filter_effrtr) {
> +       .testcase = 13,
> +       .id = ID,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .exp_num_rx = 1,
> +       .exp_flags = {
> +               0,
> +       },
> +};
> +/* Receive only EFF data frame when filtering for EFF but no RTR flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_eff) {
> +       .testcase = 14,
> +       .id = ID | CAN_EFF_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .exp_num_rx = 1,
> +       .exp_flags = {
> +               CAN_EFF_FLAG,
> +       },
> +};
> +/* Receive only SFF remote frame when filtering for RTR but no EFF flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_rtr) {
> +       .testcase = 15,
> +       .id = ID | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .exp_num_rx = 1,
> +       .exp_flags = {
> +               CAN_RTR_FLAG,
> +       },
> +};
> +/* Receive only EFF remote frame when filtering for EFF and RTR flag */
> +FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_effrtr) {
> +       .testcase = 16,
> +       .id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .exp_num_rx = 1,
> +       .exp_flags = {
> +               CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       },
> +};
> +
> +/* Receive only SFF data frame when filtering for no EFF flag and no RTR flag
> + * but based on EFF mask
> + */
> +FIXTURE_VARIANT_ADD(can_filters, eff) {
> +       .testcase = 17,
> +       .id = ID,
> +       .mask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .exp_num_rx = 1,
> +       .exp_flags = {
> +               0,
> +       },
> +};
> +/* Receive only EFF data frame when filtering for EFF flag and no RTR flag but
> + * based on EFF mask
> + */
> +FIXTURE_VARIANT_ADD(can_filters, eff_eff) {
> +       .testcase = 18,
> +       .id = ID | CAN_EFF_FLAG,
> +       .mask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
> +       .exp_num_rx = 1,
> +       .exp_flags = {
> +               CAN_EFF_FLAG,
> +       },
> +};
> +
> +/* This test verifies that the raw CAN filters work, by checking if only frames
> + * with the expected set of flags are received. For each test case, the given
> + * filter (id and mask) is added and four CAN frames are sent with every
> + * combination of set/unset EFF/RTR flags.
> + */
> +TEST_F(can_filters, test_filter)
> +{
> +       struct can_filter rfilter;
> +       int ret;
> +
> +       rfilter.can_id = variant->id;
> +       rfilter.can_mask = variant->mask;
> +       setsockopt(self->sock, SOL_CAN_RAW, CAN_RAW_FILTER,
> +                  &rfilter, sizeof(rfilter));
> +
> +       TH_LOG("filters: can_id = 0x%08X can_mask = 0x%08X",
> +               rfilter.can_id, rfilter.can_mask);
> +
> +       ret = send_can_frames(self->sock, variant->testcase);
> +       ASSERT_EQ(0, ret)
> +               TH_LOG("failed to send CAN frames");
> +
> +       for (int i = 0; i <= variant->exp_num_rx; i++) {
> +               struct can_frame frame;
> +               struct timeval tv;

Nitpick: you can directly initialize this variable:

        struct timeval tv = {
                .tv_sec = 0,
                .tv_usec = 50000, /* 50ms timeout */
        };

> +               fd_set rdfs;
> +
> +               FD_ZERO(&rdfs);
> +               FD_SET(self->sock, &rdfs);
> +               tv.tv_sec = 0;
> +               tv.tv_usec = 50000; /* 50ms timeout */
> +
> +               ret = select(self->sock + 1, &rdfs, NULL, NULL, &tv);
> +               ASSERT_LE(0, ret)
> +                       TH_LOG("failed select for frame %d, err: %d)", i, errno);
> +
> +               ret = FD_ISSET(self->sock, &rdfs);
> +               if (i == variant->exp_num_rx) {
> +                       ASSERT_EQ(0, ret)
> +                               TH_LOG("too many frames received");
> +               } else {
> +                       ASSERT_NE(0, ret)
> +                               TH_LOG("too few frames received");
> +
> +                       ret = read(self->sock, &frame, sizeof(frame));
> +                       ASSERT_LE(0, ret)
> +                               TH_LOG("failed to read frame %d, err: %d", i, errno);
> +
> +                       TH_LOG("rx: can_id = 0x%08X rx = %d", frame.can_id, i);
> +
> +                       ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
> +                               TH_LOG("received wrong can_id");
> +                       ASSERT_EQ(variant->testcase, frame.data[0])
> +                               TH_LOG("received wrong test case");
> +
> +                       ASSERT_EQ(frame.can_id & ~CAN_ERR_MASK,
> +                                 variant->exp_flags[i])
> +                               TH_LOG("received unexpected flags");
> +

Remove this empty line.

> +               }
> +       }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       char *ifname = getenv("VCANIF");
> +
> +       if (ifname) {
> +               strncpy(VCANIF, ifname, sizeof(VCANIF) - 1);
> +       } else {
> +               printf("VCANIF environment variable must contain the test interface\n");
> +               return KSFT_FAIL;
> +       }

Nitpick: test the error condition first:

        if (!ifname) {
                printf("VCANIF environment variable must contain the
test interface\n");
                return KSFT_FAIL;
        }

        strncpy(VCANIF, ifname, sizeof(VCANIF) - 1);

> +       return test_harness_run(argc, argv);
> +}
> diff --git a/tools/testing/selftests/net/can/test_raw_filter.sh b/tools/testing/selftests/net/can/test_raw_filter.sh
> new file mode 100755
> index 000000000000..95f45c3c824b
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_raw_filter.sh
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ALL_TESTS="
> +       test_raw_filter
> +"
> +
> +net_dir=$(dirname $0)/..
> +source $net_dir/lib.sh
> +
> +export VCANIF="vcan0"

Could you make it so that if the environment variable is already set,
you do not override it?

  : ${CANIF:=vcan0}
  export CANIF

This way, users can easily test other interfaces without having to
edit the script.

> +setup()
> +{
> +       ip link add name $VCANIF type vcan || exit $ksft_skip
> +       ip link set dev $VCANIF up
> +       pwd
> +}
> +
> +cleanup()
> +{
> +       ip link delete $VCANIF
> +}
> +
> +test_raw_filter()
> +{
> +       ./test_raw_filter
> +       check_err $?
> +       log_test "test_raw_filter"
> +}
> +
> +trap cleanup EXIT
> +setup
> +
> +tests_run
> +
> +exit $EXIT_STATUS
> --
> 2.49.0
>
>

