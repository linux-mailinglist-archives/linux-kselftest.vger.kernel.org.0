Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9864E49A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 00:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiCVX3l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 19:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbiCVX3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 19:29:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B342490
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Mar 2022 16:28:11 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d62so22000906iog.13
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Mar 2022 16:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R66nWDjsfLj4hjtI0s6JhgWUEJy9b55gIjTCULj3vUE=;
        b=cBWHvCrpaEa8cHt3Rhv4Mzqjzk8h7DOzSK8tKvAwHqBsQGkKj0kgNGRw/aLG3S+nga
         rA1h4sxH3OCmGxmqUVO9G0rg82ceVpGzxoOYU6FPDrs8/J88t8TB0OttInujiCy1QhYa
         Yl3LJ7g9+LDC0Pqk5bmPj3c55Tg3o5dtFGpwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R66nWDjsfLj4hjtI0s6JhgWUEJy9b55gIjTCULj3vUE=;
        b=c1B55w3Ufu9STS1MPjwnHpfSKTPAZUrQrZp4Td8uLoXQBx5JRVhOCB4LvDrq6dN78d
         Ep/lCFKf/qN78xrOBzwewG4eM4rMUmGZYcXUhE3kdVTRsEwQM+l2r5fbgLp950zD9uPt
         JQXIdFcYFcwbYjBldhzSTCB+AzOnJ/LZM6Jz1cDOglFxswQ9ixgkDY4UPYJft41kmV/z
         DNaJLVyer/uSYP3OKL4z9AUppn6oU0/buxZRY1Z3KaArlwzlpX3/z4cDQ1YOs8xPrgxc
         R85xVBugJcSFWY+O/rym86xv/2i1/RjcptW7kElgnfnz8vAwvR4BwZTcgkwLQeShEBoX
         MI2A==
X-Gm-Message-State: AOAM531eBC8qQACHa3L4fkCkSil63rIXQ13m7pWG01G3YRvH5e+ywQmP
        5djTmbaehEMq06rSc5JTutY4cw==
X-Google-Smtp-Source: ABdhPJxcWUt8V2r+2lbs545Zve16wDPDArGTeLLLdpuxvG5C1NUvHJ3MRzW7FOp3jqTuSegCF5Vziw==
X-Received: by 2002:a02:cd11:0:b0:317:b06c:3569 with SMTP id g17-20020a02cd11000000b00317b06c3569mr14614114jaq.256.1647991690577;
        Tue, 22 Mar 2022 16:28:10 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i5-20020a6bf405000000b00645be60c31csm10621646iog.23.2022.03.22.16.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 16:28:10 -0700 (PDT)
Subject: Re: [PATCH net-next] selftests/net: mctp: Roundtrip tun tests
To:     Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220322071934.2655827-1-matt@codeconstruct.com.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <18240e3b-15f0-f961-cbbc-240b54dd71b1@linuxfoundation.org>
Date:   Tue, 22 Mar 2022 17:28:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220322071934.2655827-1-matt@codeconstruct.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/22/22 1:19 AM, Matt Johnston wrote:
> Tests MCTP messages between two tun devices forwarding between
> each other.
> 
> Tests are:
> - Round trip message and reply
> - MCTP_NET_ANY and MCTP_ADDR_ANY listeners
> - Message fragmentation
> - Message key expiry timeout are dropped
> - Duplicate replies are dropped
> 
> Requires "mctp" userspace utility to configure addresses and routes,
> tests will be skipped if it is not available.
> 

Are you adding this test to main Makefile? If so you will need to chane
selftests/Makefile

> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
>   tools/testing/selftests/net/mctp/Makefile    |  11 +
>   tools/testing/selftests/net/mctp/config      |   2 +
>   tools/testing/selftests/net/mctp/mctp-defs.h |   5 +
>   tools/testing/selftests/net/mctp/mctp-tun.c  | 422 +++++++++++++++++++
>   4 files changed, 440 insertions(+)
>   create mode 100644 tools/testing/selftests/net/mctp/Makefile
>   create mode 100644 tools/testing/selftests/net/mctp/config
>   create mode 100644 tools/testing/selftests/net/mctp/mctp-defs.h
>   create mode 100644 tools/testing/selftests/net/mctp/mctp-tun.c

Add .gitignore for the generated executables.

> 
> diff --git a/tools/testing/selftests/net/mctp/Makefile b/tools/testing/selftests/net/mctp/Makefile
> new file mode 100644
> index 000000000000..baee43d5b048
> --- /dev/null
> +++ b/tools/testing/selftests/net/mctp/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
> +CFLAGS += -I../../../../../usr/include/
> +
> +TEST_PROGS := mctp-tun

TEST_PROGS are shell scripts. TEST_GEN_PROGS is the correct variable
to use for this test execuatble.

> +include ../../lib.mk
> +
> +mctp-tun: LDLIBS += -lpthread
> +
> +all: $(TEST_PROGS)
> diff --git a/tools/testing/selftests/net/mctp/config b/tools/testing/selftests/net/mctp/config
> new file mode 100644
> index 000000000000..92c0b8c79ac7
> --- /dev/null
> +++ b/tools/testing/selftests/net/mctp/config
> @@ -0,0 +1,2 @@
> +CONFIG_TUN=y
> +CONFIG_MCTP=y
> diff --git a/tools/testing/selftests/net/mctp/mctp-defs.h b/tools/testing/selftests/net/mctp/mctp-defs.h
> new file mode 100644
> index 000000000000..fcb1f5250ca9
> --- /dev/null
> +++ b/tools/testing/selftests/net/mctp/mctp-defs.h
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Protocol numbers are not exposed through uapi */
> +#ifndef AF_MCTP
> +#define AF_MCTP 45
> +#endif
> diff --git a/tools/testing/selftests/net/mctp/mctp-tun.c b/tools/testing/selftests/net/mctp/mctp-tun.c
> new file mode 100644
> index 000000000000..ce289b10d23f
> --- /dev/null
> +++ b/tools/testing/selftests/net/mctp/mctp-tun.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021,2022 Code Construct
> + */
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/ioctl.h>
> +#include <sys/random.h>
> +#include <linux/if.h>
> +#include <linux/if_tun.h>
> +#include <linux/mctp.h>
> +#include <pthread.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <assert.h>
> +
> +#include "mctp-defs.h"
> +
> +#include "../../kselftest_harness.h"
> +
> +static const int BUF_SIZE = 70000;
> +
> +static void *tun_start(void *arg);
> +static int create_tun(struct __test_metadata *_metadata,
> +	const char *name);
> +
> +FIXTURE(TUNPAIR) {
> +	pthread_t pth;
> +	int fd[2];
> +	volatile bool running;
> +	bool skip;
> +};
> +
> +const size_t default_mtu = 70;
> +const size_t default_msglen = 4;
> +
> +FIXTURE_VARIANT(TUNPAIR) {
> +	/* some defaults above */
> +	size_t msglen;
> +	size_t mtu;
> +	bool listen_addr_any;
> +	bool listen_net_any;
> +	bool expire_key;
> +	bool duplicate_reply;
> +};
> +
> +FIXTURE_VARIANT_ADD(TUNPAIR, len4) {
> +	.listen_addr_any = true,
> +	.listen_net_any = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(TUNPAIR, len300) {
> +	.msglen = 300,
> +	.mtu = 500,
> +	.listen_addr_any = true,
> +};
> +
> +/* With fragmentation */
> +FIXTURE_VARIANT_ADD(TUNPAIR, len300frag) {
> +	.msglen = 300,
> +	.listen_addr_any = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(TUNPAIR, net_any) {
> +	.listen_addr_any = true,
> +	.listen_net_any = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(TUNPAIR, addr_specific) {
> +	.listen_net_any = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(TUNPAIR, expire_key) {
> +	.expire_key = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(TUNPAIR, duplicate_reply) {
> +	.duplicate_reply = true,
> +};
> +
> +FIXTURE_SETUP(TUNPAIR)
> +{
> +	int rc;
> +	char str[1000];
> +	int mtu;
> +
> +	memset(self, 0, sizeof(*self));
> +
> +	/* Check requirements first */
> +	/* TODO: cap_get() instead? */
> +	if (getuid() != 0) {
> +		self->skip = 1;
> +		TH_LOG("Not root, skipping");

Change this message to "Run this test as root. Skipping"

> +		return;
> +	}
> +
> +	rc = system("sh -c \"which mctp 2> /dev/null > /dev/null\"");
> +	if (rc != 0) {
> +		self->skip = 1;
> +		TH_LOG("No mctp utility installed, skipping");

Change this message to "Install mctp utility to run this test. Skipping"

> +		return;
> +	}
> +
> +	rc = socket(AF_MCTP, SOCK_DGRAM, 0);
> +	if (rc == -1 && errno == EAFNOSUPPORT) {
> +		self->skip = 1;
> +		TH_LOG("No AF_MCTP support, skipping");

Change the message to "AF_MCTP support is required to run this test. Skipping"

I assume this servers as a check for CONFIG_TUN and CONFIG_MCTP?

> +		return;
> +	}
> +	close(rc);
> +
> +	/* Pair of netdevs */
> +	self->fd[0] = create_tun(_metadata, "mctptun1");
> +	self->fd[1] = create_tun(_metadata, "mctptun2");
> +
> +	mtu = variant->mtu ?: default_mtu;
> +
> +	/* Forward packets between devices */
> +	self->running = true;
> +	rc = pthread_create(&self->pth, NULL, tun_start, self);
> +	ASSERT_EQ(rc, 0);
> +
> +	/* Set up devices. All in one command to avoid
> +	 * slow shell invocations
> +	 */
> +	rc = snprintf(str, sizeof(str),
> +		/* net needs to be set before routes */
> +		"mctp link set mctptun1 up net 31 mtu %d && "
> +		"mctp link set mctptun2 up net 32 mtu %d && "
> +		"mctp addr add 131 dev mctptun1 && "
> +		"mctp addr add 132 dev mctptun2 && "
> +		"mctp route add 132 via mctptun1 && "
> +		"mctp route add 131 via mctptun2 && "
> +		"true",
> +		mtu, mtu);
> +	ASSERT_LT(rc, sizeof(str));
> +	rc = system(str);
> +	ASSERT_EQ(rc, 0);
> +}
> +
> +FIXTURE_TEARDOWN(TUNPAIR)
> +{
> +	int rc;
> +
> +	if (self->skip)
> +		return;
> +
> +	self->running = false;
> +	rc = pthread_join(self->pth, NULL);
> +	ASSERT_EQ(rc, 0);
> +	ASSERT_EQ(close(self->fd[0]), 0);
> +	ASSERT_EQ(close(self->fd[1]), 0);
> +
> +	/* mctp addr/routes go away with devices */
> +}
> +
> +/* Creates a socket, binds.
> + * Always returns success, asserts on failure
> + */
> +static int mctp_bind(struct __test_metadata *_metadata,
> +	int net, int eid, int type)
> +{
> +	struct sockaddr_mctp addr = {0};
> +	int sd, rc;
> +
> +	sd = socket(AF_MCTP, SOCK_DGRAM, 0);
> +	ASSERT_GE(sd, 0);
> +	addr.smctp_family = AF_MCTP;
> +	addr.smctp_network = net;
> +	addr.smctp_addr.s_addr = eid;
> +	addr.smctp_type = type;
> +	addr.smctp_tag = MCTP_TAG_OWNER;
> +	rc = bind(sd, (struct sockaddr *)&addr, sizeof(addr));
> +	ASSERT_EQ(rc, 0);
> +	return sd;
> +}
> +
> +/* Creates a socket, sends on it.
> + * Always returns success, asserts on failure.
> + * Returns the socket sd.
> + */
> +static int mctp_send(struct __test_metadata *_metadata,
> +	int net, int eid, int type, void *buf, size_t len)
> +{
> +	struct sockaddr_mctp addr = {0};
> +	ssize_t sent;
> +	int sd;
> +
> +	addr.smctp_family = AF_MCTP;
> +	addr.smctp_network = net;
> +	addr.smctp_addr.s_addr = eid;
> +	addr.smctp_type = type;
> +	addr.smctp_tag = MCTP_TAG_OWNER;
> +	sd = socket(AF_MCTP, SOCK_DGRAM, 0);
> +	ASSERT_GE(sd, 0);
> +	sent = sendto(sd, buf, len, 0,
> +			(struct sockaddr *)&addr, sizeof(addr));
> +	ASSERT_EQ(sent, len);
> +	return sd;
> +}
> +
> +/* Helper to test key expiry */
> +static void test_expire_key(struct __test_metadata *_metadata,
> +	int sock_listen, int sd, struct sockaddr_mctp *addr)
> +{
> +	struct pollfd pf = { .fd = sd, .events = POLLIN };
> +	int val1 = 0x11223344;
> +	ssize_t len;
> +	int rc;
> +
> +	/* Wait for timeout, > mctp_key_lifetime = 6 secs */
> +	TH_LOG("Waiting 7 seconds for key expiry...");
> +	sleep(7);
> +
> +	addr->smctp_tag &= ~MCTP_TAG_OWNER;
> +	len = sendto(sock_listen, &val1, sizeof(val1),
> +		0, (struct sockaddr *)addr, sizeof(*addr));
> +	ASSERT_EQ(len, sizeof(val1));
> +
> +	/* Wait 100ms */
> +	rc = poll(&pf, 1, 100);
> +	/* We should time out, packet is never received */
> +	ASSERT_EQ(rc, 0);
> +}
> +
> +/* Helper to test duplicate replies */
> +static void test_duplicate_reply(struct __test_metadata *_metadata,
> +	int sock_listen, int sd, struct sockaddr_mctp *addr)
> +{
> +	struct pollfd pf = { .fd = sd, .events = POLLIN };
> +	int val1 = 0x11223344;
> +	ssize_t len;
> +	int rc;
> +
> +	/* Send first reply */
> +	addr->smctp_tag &= ~MCTP_TAG_OWNER;
> +	len = sendto(sock_listen, &val1, sizeof(val1),
> +		0, (struct sockaddr *)addr, sizeof(*addr));
> +	ASSERT_EQ(len, sizeof(val1));
> +
> +	/* Receive reply */
> +	len = recvfrom(sd, NULL, 0, MSG_TRUNC, NULL, NULL);
> +	EXPECT_EQ(len, sizeof(val1));
> +
> +	/* Try a second reply */
> +	len = sendto(sock_listen, &val1, sizeof(val1),
> +		0, (struct sockaddr *)addr, sizeof(*addr));
> +	ASSERT_EQ(len, sizeof(val1));
> +
> +	/* Wait 100ms */
> +	rc = poll(&pf, 1, 100);
> +	/* We should time out, packet is never received */
> +	ASSERT_EQ(rc, 0);
> +}
> +
> +TEST_F(TUNPAIR, roundtrip)
> +{
> +	const size_t msglen = variant->msglen ?: default_msglen;
> +	struct sockaddr_mctp addr = {0};
> +	int sock_listen, sd;
> +	void *buf1, *buf2;
> +	socklen_t addrlen;
> +	int net, eid;
> +	ssize_t len;
> +
> +	if (self->skip)
> +		SKIP(return, "Skipping");
> +
> +	buf1 = malloc(msglen);
> +	buf2 = malloc(msglen);
> +
> +	/* Listen on mctptun2 (eid 132 net 32) */
> +	if (variant->listen_net_any)
> +		net = MCTP_NET_ANY;
> +	else
> +		net = 32;
> +
> +	if (variant->listen_addr_any)
> +		eid = MCTP_ADDR_ANY;
> +	else
> +		eid = 132;
> +
> +	sock_listen = mctp_bind(_metadata, net, eid, 1);
> +
> +	/* Send mctptun1 -> mctptun2 */
> +	getrandom(buf1, msglen, 0);
> +	sd = mctp_send(_metadata, 31, 132, 1, buf1, msglen);
> +
> +	/* Receive it */
> +	addrlen = sizeof(addr);
> +	len = recvfrom(sock_listen, buf2, msglen, MSG_TRUNC,
> +		(struct sockaddr *)&addr, &addrlen);
> +	EXPECT_EQ(len, msglen);
> +	EXPECT_EQ(memcmp(buf1, buf2, msglen), 0);
> +	TH_LOG("addr family %d ", addr.smctp_family);
> +
> +	if (variant->expire_key) {
> +		test_expire_key(_metadata, sock_listen, sd, &addr);
> +	} else if (variant->duplicate_reply) {
> +		test_duplicate_reply(_metadata, sock_listen, sd, &addr);
> +	} else {
> +		/* Reply mctptun2 -> mctptun1 */
> +		getrandom(buf1, msglen, 0);
> +		addr.smctp_tag &= ~MCTP_TAG_OWNER;
> +		len = sendto(sock_listen, buf1, msglen,
> +			0, (struct sockaddr *)&addr, sizeof(addr));
> +		ASSERT_EQ(len, msglen);
> +
> +		/* Receive reply */
> +		addrlen = sizeof(addr);
> +		len = recvfrom(sd, buf2, msglen, MSG_TRUNC,
> +			(struct sockaddr *)&addr, &addrlen);
> +		EXPECT_EQ(len, msglen);
> +		EXPECT_EQ(memcmp(buf1, buf2, msglen), 0);
> +	}
> +
> +	close(sd);
> +	close(sock_listen);
> +	free(buf2);
> +	free(buf1);
> +}
> +
> +/* Returns file descriptor.
> + * Asserts on failure
> + */
> +static int create_tun(struct __test_metadata *_metadata,
> +	const char *name)
> +{
> +	struct ifreq ifr = {0};
> +	int rc;
> +	int fd;
> +
> +	fd = open("/dev/net/tun", O_RDWR);
> +	ASSERT_GE(fd, 0);
> +
> +	assert(strlen(name) < IFNAMSIZ);
> +	strcpy(ifr.ifr_name, name);
> +	ifr.ifr_flags = IFF_TUN;
> +
> +	rc = ioctl(fd, TUNSETIFF, &ifr);
> +	ASSERT_EQ(rc, 0) TH_LOG("tun ioctl failed: %s",
> +		strerror(errno));
> +	return fd;
> +}
> +
> +static int atomic_write(int fd, void *buffer, size_t len)
> +{
> +	while (len) {
> +		ssize_t wlen = write(fd, buffer, len);
> +
> +		if (wlen == -1 && errno == EINTR)
> +			continue;
> +
> +		if (wlen < 0)
> +			return wlen;
> +
> +		len -= wlen;
> +		buffer += wlen;
> +	}
> +	return 0;
> +}
> +
> +
> +/* Thread to forward messages between FDs */
> +static void *tun_start(void *arg)
> +{
> +	struct _test_data_TUNPAIR *fix = arg;
> +	struct pollfd pf[2] = {
> +		{ .fd = fix->fd[0], .events = POLLIN },
> +		{ .fd = fix->fd[1], .events = POLLIN },
> +	};
> +	char *buffer = NULL;
> +	ssize_t len;
> +	int rc;
> +
> +	buffer = malloc(BUF_SIZE);
> +	if (!buffer) {
> +		fprintf(stderr, "malloc failed");
> +		goto out;
> +	}
> +
> +	while (fix->running) {
> +		rc = poll(pf, 2, 100);
> +		if (rc == 0 || (rc == -1 && errno == EINTR)) {
> +			continue;
> +		}
> +		if (rc < 0) {
> +			fprintf(stderr, "poll error: %s", strerror(errno));
> +			goto out;
> +		}
> +
> +		for (int i = 0; i < 2; i++) {
> +			if (pf[i].revents & POLLIN) {
> +				len = read(pf[i].fd, buffer, BUF_SIZE);
> +				if (len == -1 && errno == EINTR) {
> +					continue;
> +				}
> +				if (len == 0) {
> +					fprintf(stderr, "EOF from tun");
> +					goto out;
> +				}
> +				if (len < 0) {
> +					fprintf(stderr, "error from tun read: %s",
> +						strerror(errno));
> +					goto out;
> +				}
> +
> +				rc = atomic_write(pf[(i+1) % 2].fd, buffer, len);
> +				if (rc < 0) {
> +					fprintf(stderr, "error from tun write: %s",
> +						strerror(errno));
> +					goto out;
> +				}
> +			}
> +		}
> +	}
> +out:
> +	return NULL;
> +}
> +
> +TEST_HARNESS_MAIN
> 

Couple of thoughts. If you were to write wrapper shell script,
you could check for requirements: configs, mctp presence from
the shell script and then run mctp-tun from the shell scripts.
This is a just a suggestion if adding shell script makes things
easier especially checking the configs.

With the comments addressed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


