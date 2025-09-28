Return-Path: <linux-kselftest+bounces-42556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A0BA77BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 22:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350943B4C93
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D3A28C5B1;
	Sun, 28 Sep 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ero7vbJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758821FF36;
	Sun, 28 Sep 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092461; cv=none; b=OLfjNAJulX+sU4an81bhiHJgwwrmwMXL73gWiIKee8AtyBY5IIX5C2ml6GvG9wzBwVH5vi/1Sn4DiUKrn+glVMza3nYKIALkHC9NqZJyBky8QgAmt59a61wqBkcQgPVvy4dG7vTbFregLRRCZ/CGdNDyPl1e0fRvBWoHnM50MNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092461; c=relaxed/simple;
	bh=LAd4pDAYWJI1MVxKOTfz9WXudLornuXRcsFgsrd6nkk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYbyyizibZA6Pli0EYJtoj9CdF4/AF8TPbwNIwCbf1gou1He9zmQ+TqGiooHrMCwiQfuXScI6N6xM5yZKO2K4OhkxwM9UpCMdqCJhJ3YYNqWRq5SvDU9UCu+mM9t9cXMlA7ehYww1LQFOfdO1l7MJXA6HuoX0iB2E1je/0oJvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ero7vbJG; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1759092450; x=1759351650;
	bh=0Fgh3rFZS9ggeNfJATMjKlsZ3YfQYTLPRpXEp/NnVY8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ero7vbJGAflBQS2fYbfDlHmRqI2OytrrAL1uXkC4CkmBdTTcwVDillFKHSjETWUzR
	 I/a35LRAxUedTEmxh7Wnewlsp2h0M57UekC2jJfMOXOuKGpYK9aCJ/gA0VVlW1aMCz
	 DdlvIg49cS1fBWW4IRBQYgroGvC4/00iZKR/15t9RnlHepCXIh08sBtJfRnat8MU5P
	 FeOEVQ2LN8y133ELqQGioJzaH/bl9sBFHdgRbxfHHujqMjq5JzSem78x/g3uyy4AGs
	 Pnx59jmGDCwtWbgaH46yXY6v0I9ZPtwGfzlj5ftXX3RSf2He7Dj8lFzWCgJ+e7OXOh
	 IayugxX2F2ipA==
Date: Sun, 28 Sep 2025 20:47:24 +0000
To: kuba@kernel.org, pabeni@redhat.com
From: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
Cc: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>, davem@davemloft.net, dsahern@kernel.org, kuniyu@google.com, kuniyu@amazon.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] selftests/net: add netdevsim.c
Message-ID: <20250928204708.1613737-1-maksimilijan.marosevic@proton.me>
In-Reply-To: <u3HUdiCPiMCv5kkEVMXU9bKhZLDParnZCqUybez-bALHM78ymOclmc2pzUXgAGu-Bdwi30aV_LJkhicY2rwhZdjBzvYWyErXQpDQN3w4Ihs=@proton.me>
References: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me> <20250904090301.552ef178@kernel.org> <u3HUdiCPiMCv5kkEVMXU9bKhZLDParnZCqUybez-bALHM78ymOclmc2pzUXgAGu-Bdwi30aV_LJkhicY2rwhZdjBzvYWyErXQpDQN3w4Ihs=@proton.me>
Feedback-ID: 97766065:user:proton
X-Pm-Message-ID: 6992aaf3280881befdfc42d314b6bf4ab2e50cd3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tests an edge case in the nsim module where gw_family =3D=3D AF_UNSPEC.

Works by creating a new nsim device and then sending a multipath
path message to it and loopback. In unpatched kernels, this triggers
a WARN_ON_ONCE in netdevsim/fib.c.

Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Da259a17220263c2d73fc
Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config()=
.")
Signed-off-by: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
---
 tools/testing/selftests/net/netdevsim.c | 391 ++++++++++++++++++++++++
 1 file changed, 391 insertions(+)
 create mode 100644 tools/testing/selftests/net/netdevsim.c

diff --git a/tools/testing/selftests/net/netdevsim.c b/tools/testing/selfte=
sts/net/netdevsim.c
new file mode 100644
index 000000000000..cdc8ebef4dac
--- /dev/null
+++ b/tools/testing/selftests/net/netdevsim.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This test creates a new netdevsim device and then sends
+ * an IPv6 multipath netlink message to it and the loopback
+ * interface.
+ *
+ * This triggers an edge case where the routing table is
+ * constructed with an entry where gw_family =3D AF_UNSPEC.
+ * If not caught, this causes an unexpected nsiblings count
+ * in netdevsim/fib.c: nsim_fib6_event_init(), raising a
+ * warning.
+ *
+ * NOTE: The warning in question is raised by WARN_ON_ONCE.
+ * Therefore, this test reports a false negative if the
+ * warning has already been triggered.
+ *
+ */
+
+#include <arpa/inet.h>
+#include <bits/types/struct_iovec.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <netinet/in.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include <dirent.h>
+#include <stdbool.h>
+#include <net/if.h>
+
+#define RTF_UP 0x0001 // route usable
+#define RTF_HOST 0x0004 // host entry (net otherwise)
+
+#define NSIM_PORTS 1
+#define NETDEVSIM_DEV_DIR "/sys/bus/netdevsim/devices"
+#define NSIM_DEV_DIR_BUFFER_SIZE 128
+#define LO_DEV "lo"
+
+#define BUFSIZE 4096
+#define DST_PREFIX "2001:db8::"
+#define GW1 "fe80::1"
+#define GW2 "::1"
+
+#define PID_LEN 16
+
+int get_free_idx(void)
+{
+=09int idx =3D 0;
+=09int tmp =3D 0;
+=09DIR *nsim_dir =3D opendir(NETDEVSIM_DEV_DIR);
+=09struct dirent *entry =3D NULL;
+
+=09if (nsim_dir =3D=3D NULL) {
+=09=09fprintf(stderr, "Unable to open nsim directory\n");
+=09=09return -1;
+=09}
+
+=09do {
+=09=09entry =3D readdir(nsim_dir);
+=09=09if (entry !=3D NULL &&
+=09=09    sscanf(entry->d_name, "netdevsim%d", &tmp) > 0) {
+=09=09=09if (tmp >=3D idx)
+=09=09=09=09idx =3D tmp + 1;
+=09=09}
+=09} while (entry !=3D NULL);
+
+=09closedir(nsim_dir);
+=09return idx;
+}
+
+int create_netdevsim_device(int id, int num_ports)
+{
+=09const char *path =3D "/sys/bus/netdevsim/new_device";
+=09char buffer[64];
+=09int fd;
+
+=09fd =3D open(path, O_WRONLY);
+=09if (fd < 0) {
+=09=09fprintf(stderr, "Failed to open new_device\n");
+=09=09return -1;
+=09}
+
+=09snprintf(buffer, sizeof(buffer), "%d %d", id, num_ports);
+=09if (write(fd, buffer, strlen(buffer)) < 0) {
+=09=09fprintf(stderr, "Failed to write to new_device\n");
+=09=09close(fd);
+=09=09return -1;
+=09}
+
+=09close(fd);
+=09return 0;
+}
+
+int ensure_nsim_dev_exists(void)
+{
+=09int ret;
+=09int nsim_idx;
+
+=09nsim_idx =3D get_free_idx();
+=09ret =3D create_netdevsim_device(nsim_idx, NSIM_PORTS);
+=09if (ret !=3D 0) {
+=09=09fprintf(stderr, "Failed to create nsim device\n");
+=09=09return -1;
+=09}
+
+=09return nsim_idx;
+}
+
+char *get_nsim_dev_link(int nsim_idx)
+{
+=09char nsim_dev_dir_buffer[NSIM_DEV_DIR_BUFFER_SIZE];
+=09DIR *nsim_dev_dir;
+=09struct dirent *entry;
+
+=09sprintf(nsim_dev_dir_buffer, "%s/netdevsim%d/%s", NETDEVSIM_DEV_DIR,
+=09=09nsim_idx, "net");
+
+=09nsim_dev_dir =3D opendir(nsim_dev_dir_buffer);
+
+=09if (nsim_dev_dir =3D=3D NULL) {
+=09=09fprintf(stderr, "Unable to open %s\n", nsim_dev_dir_buffer);
+=09=09return NULL;
+=09}
+
+=09do {
+=09=09entry =3D readdir(nsim_dev_dir);
+=09=09if (entry !=3D NULL && entry->d_name[0] !=3D '.')
+=09=09=09break;
+
+=09} while (entry !=3D NULL);
+
+=09if (entry =3D=3D NULL || entry->d_name[0] =3D=3D '.') {
+=09=09fprintf(stderr, "Device has no ports\n");
+=09=09return NULL;
+=09}
+
+=09closedir(nsim_dev_dir);
+
+=09return entry->d_name;
+}
+
+int get_nsim_dev(char **nsim_link)
+{
+=09int nsim_idx;
+=09char *nsim_dev_link;
+
+=09nsim_idx =3D ensure_nsim_dev_exists();
+=09if (nsim_idx < 0)
+=09=09return -1;
+
+=09nsim_dev_link =3D get_nsim_dev_link(nsim_idx);
+=09if (nsim_dev_link =3D=3D NULL)
+=09=09return -1;
+
+=09*nsim_link =3D nsim_dev_link;
+=09return 0;
+}
+
+int prepare_socket(void)
+{
+=09struct sockaddr_nl sa;
+=09int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+
+=09if (fd < 0) {
+=09=09fprintf(stderr, "Failed to open socket\n");
+=09=09return -1;
+=09}
+
+=09sa.nl_family =3D AF_NETLINK;
+
+=09if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
+=09=09fprintf(stderr, "Failed to bind socket\n");
+
+=09return fd;
+}
+
+struct nlmsghdr *construct_header(char **pos)
+{
+=09struct nlmsghdr *nlh =3D (struct nlmsghdr *)(*pos);
+
+=09nlh->nlmsg_type =3D RTM_NEWROUTE;
+=09nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE;
+
+=09*pos +=3D NLMSG_HDRLEN;
+
+=09return nlh;
+}
+
+void construct_rtmsg(char **pos)
+{
+=09struct rtmsg *rtm =3D (struct rtmsg *)(*pos);
+
+=09rtm->rtm_family =3D AF_INET6;
+=09rtm->rtm_table =3D RT_TABLE_MAIN;
+=09rtm->rtm_protocol =3D RTPROT_STATIC;
+=09rtm->rtm_type =3D RTN_UNICAST;
+=09rtm->rtm_scope =3D RT_SCOPE_UNIVERSE;
+=09rtm->rtm_dst_len =3D 128;
+=09rtm->rtm_flags |=3D RTF_HOST | RTF_UP;
+
+=09*pos +=3D NLMSG_ALIGN(sizeof(struct rtmsg));
+}
+
+void construct_dest(char **pos)
+{
+=09struct rtattr *rta_dest =3D (struct rtattr *)(*pos);
+=09struct in6_addr dst6;
+
+=09rta_dest->rta_type =3D RTA_DST;
+=09rta_dest->rta_len =3D RTA_LENGTH(sizeof(struct in6_addr));
+=09inet_pton(AF_INET6, DST_PREFIX, &dst6);
+=09memcpy(RTA_DATA(rta_dest), &dst6, sizeof(dst6));
+=09*pos +=3D RTA_ALIGN(rta_dest->rta_len);
+}
+
+struct rtattr *construct_multipath_hdr(char **pos)
+{
+=09struct rtattr *rta_mp =3D (struct rtattr *)(*pos);
+
+=09rta_mp->rta_type =3D RTA_MULTIPATH;
+=09*pos +=3D sizeof(struct rtattr);
+
+=09return rta_mp;
+}
+
+void add_nexthop(char **pos, int ifindex, char *gw_addr)
+{
+=09struct rtnexthop *rtnh =3D (struct rtnexthop *)(*pos);
+
+=09rtnh->rtnh_hops =3D 0;
+=09rtnh->rtnh_ifindex =3D ifindex;
+=09char *rtnh_pos =3D (char *)rtnh + RTNH_ALIGN(sizeof(struct rtnexthop));
+
+=09struct rtattr *attr =3D (struct rtattr *)rtnh_pos;
+
+=09attr->rta_type =3D RTA_GATEWAY;
+=09attr->rta_len =3D RTA_LENGTH(sizeof(struct in6_addr));
+
+=09struct in6_addr gw;
+
+=09inet_pton(AF_INET6, gw_addr, &gw);
+=09memcpy(RTA_DATA(attr), &gw, sizeof(gw));
+
+=09rtnh_pos +=3D RTA_ALIGN(attr->rta_len);
+=09rtnh->rtnh_len =3D rtnh_pos - (char *)rtnh;
+
+=09*pos =3D rtnh_pos;
+}
+
+struct nlmsghdr *construct_message(char *buf, int nsim_ifindex, int lo_ifi=
ndex)
+{
+=09char *pos =3D buf;
+=09struct nlmsghdr *nlh =3D construct_header(&pos);
+
+=09construct_rtmsg(&pos);
+=09construct_dest(&pos);
+
+=09struct rtattr *rta_mp =3D construct_multipath_hdr(&pos);
+
+=09add_nexthop(&pos, nsim_ifindex, GW1);
+=09add_nexthop(&pos, lo_ifindex, GW2);
+
+=09rta_mp->rta_len =3D pos - (char *)rta_mp;
+=09nlh->nlmsg_len =3D pos - buf;
+
+=09return nlh;
+}
+
+int send_nl_msg(struct nlmsghdr *nlh, int socket)
+{
+=09struct iovec iov =3D { .iov_base =3D nlh, .iov_len =3D nlh->nlmsg_len }=
;
+=09struct msghdr msg =3D {
+=09=09.msg_iov =3D &iov,
+=09=09.msg_iovlen =3D 1,
+=09};
+
+=09if (sendmsg(socket, (struct msghdr *)&msg, 0) < 0) {
+=09=09fprintf(stderr, "Failed to send message\n");
+=09=09return 1;
+=09}
+
+=09return 0;
+}
+
+int open_kmsg(void)
+{
+=09int fd =3D open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+
+=09if (fd < 0) {
+=09=09fprintf(stderr, "Failed to open kmsg\n");
+=09=09return -1;
+=09}
+
+=09return fd;
+}
+
+int move_cursor_to_end(int fd)
+{
+=09if (lseek(fd, 0, SEEK_END) =3D=3D -1) {
+=09=09fprintf(stderr, "Failed to lseek kmsg\n");
+=09=09return -1;
+=09}
+
+=09return 0;
+}
+
+int look_for_warn(int kmsg_fd)
+{
+=09char buffer[1024];
+=09int bytes_read;
+=09int pid =3D getpid();
+=09char pid_str[PID_LEN];
+
+=09snprintf(pid_str, PID_LEN, "%d", pid);
+
+=09while ((bytes_read =3D read(kmsg_fd, buffer, sizeof(buffer) - 1)) > 0) =
{
+=09=09buffer[bytes_read] =3D '\0';
+=09=09if (strstr(buffer, "WARNING") && strstr(buffer, pid_str)) {
+=09=09=09printf("Kernel warning detected\n");
+=09=09=09return 1;
+=09=09}
+=09}
+
+=09return 0;
+}
+
+int main(void)
+{
+=09char *nsim_dev;
+=09int if_lo, if_nsim;
+=09int fd;
+=09int kmsg_fd;
+=09struct nlmsghdr *nlh;
+=09char buf[BUFSIZE];
+
+=09if (get_nsim_dev(&nsim_dev) !=3D 0)
+=09=09return EXIT_FAILURE;
+
+=09sleep(1); // Doesn't work without a delay
+
+=09if_lo =3D if_nametoindex(LO_DEV);
+=09if_nsim =3D if_nametoindex(nsim_dev);
+
+=09if (!if_lo || !if_nsim) {
+=09=09fprintf(stderr, "Failed to get interface index\n");
+=09=09return EXIT_FAILURE;
+=09}
+
+=09memset(buf, 0, sizeof(buf));
+=09nlh =3D construct_message(buf, if_nsim, if_lo);
+
+=09fd =3D prepare_socket();
+=09if (fd < 0) {
+=09=09fprintf(stderr, "Failed to open socket\n");
+=09=09close(fd);
+=09=09return EXIT_FAILURE;
+=09}
+
+=09kmsg_fd =3D open_kmsg();
+=09if (kmsg_fd < 0) {
+=09=09fprintf(stderr, "Failed to open kmsg\n");
+=09=09close(fd);
+=09=09return EXIT_FAILURE;
+=09}
+
+=09if (move_cursor_to_end(kmsg_fd) < 0) {
+=09=09fprintf(stderr, "Failed to open kmsg\n");
+=09=09close(fd);
+=09=09close(kmsg_fd);
+=09=09return EXIT_FAILURE;
+=09}
+
+=09if (send_nl_msg(nlh, fd) !=3D 0) {
+=09=09close(fd);
+=09=09close(kmsg_fd);
+=09=09return EXIT_FAILURE;
+=09}
+
+=09if (look_for_warn(kmsg_fd) !=3D 0) {
+=09=09close(fd);
+=09=09close(kmsg_fd);
+=09=09return EXIT_FAILURE;
+=09}
+
+=09close(kmsg_fd);
+=09close(fd);
+=09return EXIT_SUCCESS;
+}
--=20
2.43.0



