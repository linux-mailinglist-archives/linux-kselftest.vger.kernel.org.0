Return-Path: <linux-kselftest+bounces-42638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D1BAD26E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 16:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7995F1C2222
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6A2FB625;
	Tue, 30 Sep 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG6d/dAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB64238D3A
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241620; cv=none; b=ElsXh+xiXVcUt+jAkxILNgzRlhpjVyB58yzL7oIHqa2/aT1JR4Q1hch+mMqPVkNo2Ge8vkny3jNc/q8a+2+tAN4IR8D82ggPIvTYuSS9U0Mh17IR976tysA0gRJR77FidxQPmw9OGWJ8d0FD82H02ZrBBt9C9FM5dHYLD0nHvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241620; c=relaxed/simple;
	bh=NQfcEbhcvlfQBrRtMigh9Paow8F9UBWwaoBp4slJZ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DymV1+8mK+vaJLup5GBZIXn+gTHVHNPqiTcW0dRbohPZu0SqnIWdf0bLC7mvXVpD/50vL21G9npFtI3+nJfyaezn9lOCgedrZRZ/rmABg9/0bYx2MS5UBGizcxW3DSuqryKHQAGbGa9D+gHvaibeyqrXL8JYoAA+MbN/IjqMGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DG6d/dAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759241616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga1WW+ggE9QRU4566JMlQTW/rcoTrT0dzp6WctPGORY=;
	b=DG6d/dAtzufgsPBorzqYy9Jm06v+nt2MFH6/A7DmljZIgxuKpx7keYboSDCsnbQqklJ48J
	3SE718N1zEn4Eebo1s6lwgpeWIHhdAPjHMt5LL3LjH3abRFbOBeMaxcyQMMYM433b6F4kb
	bJNaOUNscYQbJZZvt5BzG18icixXJrM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-9qvF23hCP-W5turvKgU0Lg-1; Tue, 30 Sep 2025 10:13:29 -0400
X-MC-Unique: 9qvF23hCP-W5turvKgU0Lg-1
X-Mimecast-MFC-AGG-ID: 9qvF23hCP-W5turvKgU0Lg_1759241608
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3eff3936180so2283472f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 07:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759241608; x=1759846408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga1WW+ggE9QRU4566JMlQTW/rcoTrT0dzp6WctPGORY=;
        b=WE7DoFBavmJi/x2IWNrZGSPeQyuumGX3FtnU0JBtaYglkBRVlUOBbk3EThKekGIQ+t
         MNnPKPS1Orwzwd/tg+S4baroxTys9CBeiowhNEXEdoVT51MVCAzYDGcN98DOIWQ04gEI
         o/Xz9wXCBCXGhicdl+3hWJ74SESMsAc9+TjN+psQ19Y8QJQGk7p03EqGu5OBKrd0FM4T
         QgnYxKbbE/SslB8mRspsiQ6WlZdqqxoo4ZI67wX74ciDNWqqreHbJbvVPAACOd0D9/6H
         Pke1LV75oucd2m88YYrxrxA62Q9zm8bxO/yJpDUblQ/sdPm/+cuP+fk3UPOhrC+5kzKD
         X8eA==
X-Forwarded-Encrypted: i=1; AJvYcCU3+x+QoWSqNc9cQumoo1EXt1/6TJQ+I6wdv4ojDwyFeQme8dlzWsQcoJ6B139m40QNisuIcDi/HzsV5qX172Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVM5yaYLX30miuDqtbNJFLrUnL3ensxj6BxAiwSh7Td2ABLyF6
	yKdpfpgSuo7asOoZDFsZssoPznx7a3G34kRrYGC48xSAaTFKna6kUUfQo/+6g2OsA5KB5vX9kGB
	hgBWiu6tY3PWsmvAYymFWWMNUp3tVnvBl49zltEqI9/RhYJJxtFZiMzKbLmrOIq1iXojYBQ==
X-Gm-Gg: ASbGnctUGFPpL5/VmeKM/Sg0KfM+TiMX6qmPyvpyHM1YTLo2o6DnIFQ0Qldnt+vt1UK
	uyRFVyrwLr0+wwzfAYmzqYjLtZ/kbjiHAvfYNVm6RolLlr6CnQ2rsGRMr/mMuEgVjJjrEATUCPy
	tFXzOq7+L+ThqpT9izRuOS291HUyn8oZANEK/UcvvN619dpxQaos80Q2Dmo/PDDayJZ9f30R7Ra
	t8kYgwpZH0zUCUX3hIjkzCGMo9q499C2SvA+ucK7hlHsknx4y5jXm6hl9K1lShXKNlOXDZxNQZR
	O0LPJxZfVw9ArG3U07mTZFw6cLRyf9jHtHjB34lM0Ie8TvfSa/e8sGB9EW/yDMuFwibJP5txPJM
	Z9KBCEq2FoLL4QofcWw==
X-Received: by 2002:a05:6000:2388:b0:3e7:4697:297a with SMTP id ffacd0b85a97d-40e47ee046amr19645804f8f.24.1759241608304;
        Tue, 30 Sep 2025 07:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm2rpy6sHmEbshgg3tOGgiJIpVe4LNWFe6GBGwJ+nX5Nncg18qsjR+M+8ELL8Hl3d2rYCmTg==
X-Received: by 2002:a05:6000:2388:b0:3e7:4697:297a with SMTP id ffacd0b85a97d-40e47ee046amr19645774f8f.24.1759241607798;
        Tue, 30 Sep 2025 07:13:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm24851102f8f.2.2025.09.30.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:13:27 -0700 (PDT)
Message-ID: <27a6f27a-e8a8-4bcf-bfe6-b7653777e3b5@redhat.com>
Date: Tue, 30 Sep 2025 16:13:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/net: add netdevsim.c
To: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>, kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, kuniyu@google.com,
 kuniyu@amazon.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
References: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
 <20250904090301.552ef178@kernel.org>
 <u3HUdiCPiMCv5kkEVMXU9bKhZLDParnZCqUybez-bALHM78ymOclmc2pzUXgAGu-Bdwi30aV_LJkhicY2rwhZdjBzvYWyErXQpDQN3w4Ihs=@proton.me>
 <20250928204708.1613737-1-maksimilijan.marosevic@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250928204708.1613737-1-maksimilijan.marosevic@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/25 10:47 PM, Maksimilijan Marosevic wrote:
> Tests an edge case in the nsim module where gw_family == AF_UNSPEC.
> 
> Works by creating a new nsim device and then sending a multipath
> path message to it and loopback. In unpatched kernels, this triggers
> a WARN_ON_ONCE in netdevsim/fib.c.
> 
> Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc
> Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().")
> Signed-off-by: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
> ---
>  tools/testing/selftests/net/netdevsim.c | 391 ++++++++++++++++++++++++
>  1 file changed, 391 insertions(+)
>  create mode 100644 tools/testing/selftests/net/netdevsim.c
> 
> diff --git a/tools/testing/selftests/net/netdevsim.c b/tools/testing/selftests/net/netdevsim.c
> new file mode 100644
> index 000000000000..cdc8ebef4dac
> --- /dev/null
> +++ b/tools/testing/selftests/net/netdevsim.c
> @@ -0,0 +1,391 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This test creates a new netdevsim device and then sends
> + * an IPv6 multipath netlink message to it and the loopback
> + * interface.
> + *
> + * This triggers an edge case where the routing table is
> + * constructed with an entry where gw_family = AF_UNSPEC.
> + * If not caught, this causes an unexpected nsiblings count
> + * in netdevsim/fib.c: nsim_fib6_event_init(), raising a
> + * warning.
> + *
> + * NOTE: The warning in question is raised by WARN_ON_ONCE.
> + * Therefore, this test reports a false negative if the
> + * warning has already been triggered.
> + *
> + */
> +
> +#include <arpa/inet.h>
> +#include <bits/types/struct_iovec.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <netinet/in.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <unistd.h>
> +#include <dirent.h>
> +#include <stdbool.h>
> +#include <net/if.h>
> +
> +#define RTF_UP 0x0001 // route usable
> +#define RTF_HOST 0x0004 // host entry (net otherwise)
> +
> +#define NSIM_PORTS 1
> +#define NETDEVSIM_DEV_DIR "/sys/bus/netdevsim/devices"
> +#define NSIM_DEV_DIR_BUFFER_SIZE 128
> +#define LO_DEV "lo"
> +
> +#define BUFSIZE 4096
> +#define DST_PREFIX "2001:db8::"
> +#define GW1 "fe80::1"
> +#define GW2 "::1"
> +
> +#define PID_LEN 16
> +
> +int get_free_idx(void)
> +{
> +	int idx = 0;
> +	int tmp = 0;
> +	DIR *nsim_dir = opendir(NETDEVSIM_DEV_DIR);
> +	struct dirent *entry = NULL;
> +
> +	if (nsim_dir == NULL) {

Prefer '!nsim_dir' to test for null PTR (above and elsewhere).

> +		fprintf(stderr, "Unable to open nsim directory\n");
> +		return -1;

You can probably streamline the code using the error() libcall here and
in many places below

> +	}
> +
> +	do {
> +		entry = readdir(nsim_dir);
> +		if (entry != NULL &&
> +		    sscanf(entry->d_name, "netdevsim%d", &tmp) > 0) {
> +			if (tmp >= idx)
> +				idx = tmp + 1;
> +		}
> +	} while (entry != NULL);
> +
> +	closedir(nsim_dir);
> +	return idx;
> +}
> +
> +int create_netdevsim_device(int id, int num_ports)
> +{
> +	const char *path = "/sys/bus/netdevsim/new_device";
> +	char buffer[64];
> +	int fd;
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Failed to open new_device\n");
> +		return -1;
> +	}
> +
> +	snprintf(buffer, sizeof(buffer), "%d %d", id, num_ports);
> +	if (write(fd, buffer, strlen(buffer)) < 0) {
> +		fprintf(stderr, "Failed to write to new_device\n");
> +		close(fd);
> +		return -1;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> +
> +int ensure_nsim_dev_exists(void)
> +{
> +	int ret;
> +	int nsim_idx;
> +
> +	nsim_idx = get_free_idx();
> +	ret = create_netdevsim_device(nsim_idx, NSIM_PORTS);
> +	if (ret != 0) {
> +		fprintf(stderr, "Failed to create nsim device\n");
> +		return -1;
> +	}

AFAICS the above is still racy. I think it could be made safer running
in a netns with a setup script creading an 'unique' netns name for this
test (see setup_ns() in tools/testing/selftests/net/lib.sh).

> +
> +	return nsim_idx;
> +}
> +
> +char *get_nsim_dev_link(int nsim_idx)
> +{
> +	char nsim_dev_dir_buffer[NSIM_DEV_DIR_BUFFER_SIZE];
> +	DIR *nsim_dev_dir;
> +	struct dirent *entry;
> +
> +	sprintf(nsim_dev_dir_buffer, "%s/netdevsim%d/%s", NETDEVSIM_DEV_DIR,
> +		nsim_idx, "net");
> +
> +	nsim_dev_dir = opendir(nsim_dev_dir_buffer);
> +
> +	if (nsim_dev_dir == NULL) {
> +		fprintf(stderr, "Unable to open %s\n", nsim_dev_dir_buffer);
> +		return NULL;
> +	}
> +
> +	do {
> +		entry = readdir(nsim_dev_dir);
> +		if (entry != NULL && entry->d_name[0] != '.')
> +			break;
> +
> +	} while (entry != NULL);
> +
> +	if (entry == NULL || entry->d_name[0] == '.') {
> +		fprintf(stderr, "Device has no ports\n");
> +		return NULL;
> +	}
> +
> +	closedir(nsim_dev_dir);
> +
> +	return entry->d_name;
> +}
> +
> +int get_nsim_dev(char **nsim_link)
> +{
> +	int nsim_idx;
> +	char *nsim_dev_link;
> +
> +	nsim_idx = ensure_nsim_dev_exists();
> +	if (nsim_idx < 0)
> +		return -1;
> +
> +	nsim_dev_link = get_nsim_dev_link(nsim_idx);
> +	if (nsim_dev_link == NULL)
> +		return -1;
> +
> +	*nsim_link = nsim_dev_link;
> +	return 0;
> +}
> +
> +int prepare_socket(void)
> +{
> +	struct sockaddr_nl sa;
> +	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> +
> +	if (fd < 0) {
> +		fprintf(stderr, "Failed to open socket\n");
> +		return -1;
> +	}
> +
> +	sa.nl_family = AF_NETLINK;
> +
> +	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
> +		fprintf(stderr, "Failed to bind socket\n");

Why you don't error out here? also you need to explictly zero 'sa' or
the kernel may try to bind to 'random' NL group.

> +
> +	return fd;
> +}
> +
> +struct nlmsghdr *construct_header(char **pos)
> +{
> +	struct nlmsghdr *nlh = (struct nlmsghdr *)(*pos);
> +
> +	nlh->nlmsg_type = RTM_NEWROUTE;
> +	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE;
> +
> +	*pos += NLMSG_HDRLEN;
> +
> +	return nlh;
> +}
> +
> +void construct_rtmsg(char **pos)
> +{
> +	struct rtmsg *rtm = (struct rtmsg *)(*pos);
> +
> +	rtm->rtm_family = AF_INET6;
> +	rtm->rtm_table = RT_TABLE_MAIN;
> +	rtm->rtm_protocol = RTPROT_STATIC;
> +	rtm->rtm_type = RTN_UNICAST;
> +	rtm->rtm_scope = RT_SCOPE_UNIVERSE;
> +	rtm->rtm_dst_len = 128;
> +	rtm->rtm_flags |= RTF_HOST | RTF_UP;
> +
> +	*pos += NLMSG_ALIGN(sizeof(struct rtmsg));
> +}
> +
> +void construct_dest(char **pos)
> +{
> +	struct rtattr *rta_dest = (struct rtattr *)(*pos);
> +	struct in6_addr dst6;
> +
> +	rta_dest->rta_type = RTA_DST;
> +	rta_dest->rta_len = RTA_LENGTH(sizeof(struct in6_addr));
> +	inet_pton(AF_INET6, DST_PREFIX, &dst6);
> +	memcpy(RTA_DATA(rta_dest), &dst6, sizeof(dst6));
> +	*pos += RTA_ALIGN(rta_dest->rta_len);
> +}
> +
> +struct rtattr *construct_multipath_hdr(char **pos)
> +{
> +	struct rtattr *rta_mp = (struct rtattr *)(*pos);
> +
> +	rta_mp->rta_type = RTA_MULTIPATH;
> +	*pos += sizeof(struct rtattr);
> +
> +	return rta_mp;
> +}
> +
> +void add_nexthop(char **pos, int ifindex, char *gw_addr)
> +{
> +	struct rtnexthop *rtnh = (struct rtnexthop *)(*pos);
> +
> +	rtnh->rtnh_hops = 0;
> +	rtnh->rtnh_ifindex = ifindex;
> +	char *rtnh_pos = (char *)rtnh + RTNH_ALIGN(sizeof(struct rtnexthop));
> +
> +	struct rtattr *attr = (struct rtattr *)rtnh_pos;

Please avoid mixing variable definition and code (above and elsewhere)

> +
> +	attr->rta_type = RTA_GATEWAY;
> +	attr->rta_len = RTA_LENGTH(sizeof(struct in6_addr));
> +
> +	struct in6_addr gw;
> +
> +	inet_pton(AF_INET6, gw_addr, &gw);
> +	memcpy(RTA_DATA(attr), &gw, sizeof(gw));
> +
> +	rtnh_pos += RTA_ALIGN(attr->rta_len);
> +	rtnh->rtnh_len = rtnh_pos - (char *)rtnh;
> +
> +	*pos = rtnh_pos;
> +}
> +
> +struct nlmsghdr *construct_message(char *buf, int nsim_ifindex, int lo_ifindex)
> +{
> +	char *pos = buf;
> +	struct nlmsghdr *nlh = construct_header(&pos);
> +
> +	construct_rtmsg(&pos);
> +	construct_dest(&pos);
> +
> +	struct rtattr *rta_mp = construct_multipath_hdr(&pos);
> +
> +	add_nexthop(&pos, nsim_ifindex, GW1);
> +	add_nexthop(&pos, lo_ifindex, GW2);
> +
> +	rta_mp->rta_len = pos - (char *)rta_mp;
> +	nlh->nlmsg_len = pos - buf;
> +
> +	return nlh;
> +}
> +
> +int send_nl_msg(struct nlmsghdr *nlh, int socket)
> +{
> +	struct iovec iov = { .iov_base = nlh, .iov_len = nlh->nlmsg_len };
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +	};
> +
> +	if (sendmsg(socket, (struct msghdr *)&msg, 0) < 0) {
> +		fprintf(stderr, "Failed to send message\n");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int open_kmsg(void)
> +{
> +	int fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> +
> +	if (fd < 0) {
> +		fprintf(stderr, "Failed to open kmsg\n");
> +		return -1;
> +	}
> +
> +	return fd;
> +}
> +
> +int move_cursor_to_end(int fd)
> +{
> +	if (lseek(fd, 0, SEEK_END) == -1) {
> +		fprintf(stderr, "Failed to lseek kmsg\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int look_for_warn(int kmsg_fd)
> +{
> +	char buffer[1024];
> +	int bytes_read;
> +	int pid = getpid();
> +	char pid_str[PID_LEN];
> +
> +	snprintf(pid_str, PID_LEN, "%d", pid);
> +
> +	while ((bytes_read = read(kmsg_fd, buffer, sizeof(buffer) - 1)) > 0) {
> +		buffer[bytes_read] = '\0';
> +		if (strstr(buffer, "WARNING") && strstr(buffer, pid_str)) {
> +			printf("Kernel warning detected\n");
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	char *nsim_dev;
> +	int if_lo, if_nsim;
> +	int fd;
> +	int kmsg_fd;
> +	struct nlmsghdr *nlh;
> +	char buf[BUFSIZE];
> +
> +	if (get_nsim_dev(&nsim_dev) != 0)
> +		return EXIT_FAILURE;
> +
> +	sleep(1); // Doesn't work without a delay

Why? also always use /* */ for comments.

/P


