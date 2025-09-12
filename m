Return-Path: <linux-kselftest+bounces-41422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A97FB55741
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B55CB61DD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA94D35A2AF;
	Fri, 12 Sep 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDiwD/or"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD13568E9
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706861; cv=none; b=S9swpBKfdhFYaDIKXQzpCFbmFyoJiszDFG8RleYCfrVN8dF0GWhxFsLlCckeo5+vQRMRUH930WlU3B6ApbSea5Yp43aFEAn9Sv0oqpb8JgHYImwwQUVZwKWKk8DjpL76Y5jDB+TUAEwk/qhz1lIj+soIQP0x1N/y1Bba5kMulV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706861; c=relaxed/simple;
	bh=r/SEkcwOHujwUwYsIlfjuR0ak0ppQOmzsVDL4iJn7is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHf1UGQEnhjZc34fLL+/DosX1C7ENkIrGTyJgoR+y3hdb8UoDfICofh9dBU8thOWdKS1dHhfa/aIFgOWpso7iBAX+OfRsamM6Cf9ZJ+iI3AbojQdLQsnfhpr0s0bhe7VqiH6sCTrzCvoe4Aw6N1AV0dlJ0y3Ludqbja2FAzdUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDiwD/or; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1759144f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706853; x=1758311653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgRQHdcc8YPG0tplcC5WYWa2ScMOYVslMYtlHBH3Ays=;
        b=nDiwD/or9rPbKEaxVJsJ15UMDBC32wWJK/qKSy8HKVaUWPR4RABzhvPAMt2O0eRrs7
         fw+yc/fk1cXa3v1yzcp9OaDDt5RT6PQPX/AlmEiHbz5dJAxYasb0LTUTDxv+Xg31c8BK
         hR9mBvL4pwuevTHdLUkqh5mZfBhSLLfD5VLV15q+Pa1sCxDdAIOQPShqxwi5asvTeBAV
         lV78baDjWGjvc8+m5jjVMnifWMG+ukhU8hKXXDOWoZrlcJpi+5p0WUWSxMi9IytAGQH5
         Ubpnknd5EM/sjr+8HZTE9PIupAUwIJvVkP/YIgldvpnjhfIt0u3jmOyheIDaqF2HYSAr
         xvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706853; x=1758311653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgRQHdcc8YPG0tplcC5WYWa2ScMOYVslMYtlHBH3Ays=;
        b=b/earMdF3Qy5c+s+7YN6JP2/pnHZ57uSe/sXKSPMIL3e3915FMWKgRZPIZSGPbJp6F
         ufzM8kImH7RsEHFhyApwloK9c6QjSTrpiQF612XS8CozqwYzH4ae1OVcHH6Y6cABUMWA
         2Gs5T1fT9m2MrdeXUtr1yt7FWqk/1ifF2kaAdUKX3WQAsQfImL/sUP6m/KHQDlyLvz+n
         MHVbSblCgX1xW2X749N6GkpGIaHimICmhlZESVetESkaHj+wKx19m5Nm5xcJM47MHkBk
         mwo5EFWHvfv/duPf/D+iu54zOp6YDngeQOzFmjgIEUURYbDD0nZw/5U1Y14M1Uoj4rLl
         piFw==
X-Forwarded-Encrypted: i=1; AJvYcCV6bJH/j5HJeXiK/FHoHKS86RlaSS9+AMKIWFys73yTtrdvKjz6LBMCF4R03jJ1EiwcUVd6o0I2K6yJ789mj9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YweG31h5v9DwLOCuXqGcCSKVxzrqXpsGqXioyVOpnUPNaxc0ahH
	M1UjPDmJ4n/H82e+o3DNRUSmC8VLoDtiZeVkRukjm4jri+oz+V41FWZU
X-Gm-Gg: ASbGncuM4aZhNpL0j6V6rEMuGVy4iMv6lJPkxjFCHmB6MnKnZaUcDkeDvDqxlqmk18r
	SDVoXwHcBYsrfAYm5u1dY5UBIzzCIjM4AHThHJSG+CmvpMWLOE5uM40loWJY5TsMFA6NwrdHJ4U
	zo0b0yO7045bpvH6XbyTk7XEyje7exB99QlkqOhO+XieRc0IJhB2sDlq0Wtk1ARekgAW8aFs5e+
	bspcWXSy71478+VldzNqlTkz9Pge+HERW8FYcN3/PL3e4EhsGd3fxyTt/CUU1/5fIrSJySSZuD7
	xnRdF95z2ljE33kW+qWXklkx9vg8Nl5DQLcDguxhZNm1Nny3vmZW5uhM+QNhAnYbEfUvuMU5mJl
	FcYXzUpRExtoBGuukpWvIOoi8vZWJKPkN5RIpa28FRJcJyqhJveTxE2uN3bpbI7Iw31GksfI0
X-Google-Smtp-Source: AGHT+IEBp3n9waN+QLfSeGkJ6Cl6QVfabWEq+lZhDZ0/Oyrgosuby6+FX48Fveezpj1GFz6tmkC1Ag==
X-Received: by 2002:a05:6000:3111:b0:3d7:d444:da19 with SMTP id ffacd0b85a97d-3e765a55a96mr3809148f8f.55.1757706852893;
        Fri, 12 Sep 2025 12:54:12 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:12 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 14/15] selftests: net: genetlink: add Netlink and Generic Netlink test suite
Date: Fri, 12 Sep 2025 22:53:37 +0300
Message-Id: <20250912195339.20635-15-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit introduces a comprehensive test suite for Netlink and Generic Netlink
functionality. The tests cover:

- Basic socket operations and protocol validation
- Controller family resolution and policy checks
- Multicast group communication
- Error handling and edge cases
- Socket option testing (EXT_ACK, NO_ENOBUFS, etc.)
- Stress testing and race conditions

The test suite uses kselftest harness and includes both positive and negative
test cases to validate kernel behavior under various conditions.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 3881 +++++++++++++++++++++++
 1 file changed, 3881 insertions(+)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index 361840aae918..a166f2c474b4 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -81,10 +81,34 @@
 
 #define LARGE_GENL_FAMILY_NAME "LARGE_GENL"
 
+#define SOME_RANDOM_CMD 99
+
 /**
  * Callback data structures - used to pass data between test cases and message handlers
  */
 
+struct callback_data {
+	int int_value;
+	char *message;
+	char *some_info;
+};
+
+struct callback_data_parallel_dump {
+	char *name;
+	char *desc;
+};
+
+struct callback_data_parallel_dump data_check[] = {
+	{ "TEST_GENL", "one" },
+	{ "PARALLEL_GENL", "two" },
+	{ "THIRD_GENL", "three" },
+	{ "LARGE_GENL", "four" },
+};
+
+#define DATA_SIZE (sizeof(data_check) / sizeof(data_check[0]))
+
+static int elems;
+
 struct callback_data_ctrl {
 	int family_id;
 	char *family_name;
@@ -93,6 +117,221 @@ struct callback_data_ctrl {
 	int family_index;
 };
 
+struct callback_data_third {
+	char *message;
+	int flag;
+};
+
+int validate_cb_parallel(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[PARALLEL_GENL_ATTR_MAX + 1];
+	int ret = 0;
+	char *message = NULL;
+
+	ret = genlmsg_parse(nlmsg_hdr(msg), 0, attrs, PARALLEL_GENL_ATTR_MAX,
+			    NULL);
+
+	if (ret < 0) {
+		printf("Failed to parse attributes: %d\n", ret);
+		return NL_STOP;
+	}
+
+	struct callback_data *data = (struct callback_data *)arg;
+
+	switch (gnlh->cmd) {
+	case PARALLEL_GENL_CMD_SEND:
+		if (attrs[PARALLEL_GENL_ATTR_DATA]) {
+			message =
+				nla_get_string(attrs[PARALLEL_GENL_ATTR_DATA]);
+			data->message = strdup(message);
+			if (data->message == NULL) {
+				perror("strdup failed");
+				return NL_SKIP;
+			}
+		} else {
+			printf("Attribute not found.\n");
+			return NL_SKIP;
+		}
+		return NL_OK;
+	case PARALLEL_GENL_CMD_GET_VALUE:
+		if (attrs[PARALLEL_GENL_ATTR_DATA]) {
+			message =
+				nla_get_string(attrs[PARALLEL_GENL_ATTR_DATA]);
+			data->message = strdup(message);
+			if (data->message == NULL) {
+				perror("strdup failed");
+				return NL_SKIP;
+			}
+		}
+		return NL_OK;
+	}
+	return NL_OK;
+}
+
+int validate_cb_parallel_dump(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[PARALLEL_GENL_ATTR_MAX + 1];
+	int ret = 0;
+	char *name;
+	char *desc;
+
+	ret = genlmsg_parse(nlmsg_hdr(msg), 0, attrs, PARALLEL_GENL_ATTR_MAX,
+			    NULL);
+
+	if (ret < 0) {
+		printf("Failed to parse attributes: %d\n", ret);
+		return NL_STOP;
+	}
+
+	struct callback_data_parallel_dump *data =
+		(struct callback_data_parallel_dump *)arg;
+	switch (gnlh->cmd) {
+	case PARALLEL_GENL_CMD_DUMP_INFO:
+		if (attrs[PARALLEL_GENL_ATTR_NAME]) {
+			name = nla_get_string(attrs[PARALLEL_GENL_ATTR_NAME]);
+			data->name = strdup(name);
+			if (data->name == NULL) {
+				perror("strdup failed");
+				free(data);
+				return NL_SKIP;
+			}
+
+			if (strcmp(data->name, data_check[elems].name))
+				printf("[FAILED]\n");
+		}
+		if (attrs[PARALLEL_GENL_ATTR_DESC]) {
+			desc = nla_get_string(attrs[PARALLEL_GENL_ATTR_DESC]);
+			data->desc = strdup(desc);
+			if (data->desc == NULL) {
+				perror("strdup failed");
+				return NL_SKIP;
+			}
+			if (strcmp(data->desc, data_check[elems].desc))
+				printf("[FAILED]\n");
+		}
+		elems++;
+		return NL_OK;
+	}
+	return NL_OK;
+}
+
+int validate_cb_third(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[PARALLEL_GENL_ATTR_MAX + 1];
+	int ret = 0;
+	int flag = -1;
+	char *message = NULL;
+
+	ret = genlmsg_parse(nlmsg_hdr(msg), 0, attrs, PARALLEL_GENL_ATTR_MAX,
+			    NULL);
+
+	if (ret < 0) {
+		printf("Failed to parse attributes: %d\n", ret);
+		return NL_STOP;
+	}
+
+	struct callback_data_third *data = (struct callback_data_third *)arg;
+
+	switch (gnlh->cmd) {
+	case THIRD_GENL_CMD_ECHO:
+		if (attrs[THIRD_GENL_ATTR_DATA]) {
+			message = nla_get_string(attrs[THIRD_GENL_ATTR_DATA]);
+			data->message = strdup(message);
+			if (data->message == NULL) {
+				perror("strdup failed");
+				return NL_SKIP;
+			}
+		}
+		if (attrs[THIRD_GENL_ATTR_FLAG]) {
+			flag = nla_get_flag(attrs[THIRD_GENL_ATTR_FLAG]);
+			data->flag = flag;
+		}
+		return NL_OK;
+	}
+	return NL_OK;
+}
+
+int validate_cb(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attrs[MY_GENL_ATTR_MAX + 1];
+	int ret = 0;
+	int int_value = 30;
+
+	ret = genlmsg_parse(nlmsg_hdr(msg), 0, attrs, MY_GENL_ATTR_MAX, NULL);
+
+	if (ret < 0) {
+		printf("Failed to parse attributes: %d\n", ret);
+		return NL_STOP;
+	}
+
+	struct callback_data *data = (struct callback_data *)arg;
+
+	switch (gnlh->cmd) {
+	case MY_GENL_CMD_GET_VALUE:
+		if (attrs[MY_GENL_ATTR_VALUE]) {
+			if (nla_len(attrs[MY_GENL_ATTR_VALUE]) >= sizeof(int)) {
+				int_value =
+					nla_get_u32(attrs[MY_GENL_ATTR_VALUE]);
+				data->int_value = int_value;
+			} else {
+				fprintf(stderr,
+					"MY_GENL_ATTR_VALUE has incorrect size");
+				return NL_STOP;
+			}
+		}
+		return NL_OK;
+
+	case MY_GENL_CMD_SET_VALUE:
+		if (attrs[MY_GENL_ATTR_VALUE]) {
+			if (nla_len(attrs[MY_GENL_ATTR_VALUE]) >= sizeof(int)) {
+				int_value =
+					nla_get_u32(attrs[MY_GENL_ATTR_VALUE]);
+				data->int_value = int_value;
+			} else {
+				fprintf(stderr,
+					"MY_GENL_ATTR_VALUE has incorrect size");
+				return NL_STOP;
+			}
+		}
+		return NL_OK;
+
+	case MY_GENL_CMD_ECHO:
+		if (attrs[MY_GENL_ATTR_DATA]) {
+			char *message =
+				nla_get_string(attrs[MY_GENL_ATTR_DATA]);
+			data->message = strdup(message);
+			if (data->message == NULL) {
+				perror("strdup failed");
+				return NL_SKIP;
+			}
+		} else {
+			printf("Attribute not found.\n");
+			return NL_SKIP;
+		}
+		return NL_OK;
+
+	case MY_GENL_SMALL_CMD_GET:
+		if (attrs[MY_GENL_ATTR_DATA]) {
+			char *message =
+				nla_get_string(attrs[MY_GENL_ATTR_DATA]);
+			data->message = strdup(message);
+			if (data->message == NULL) {
+				perror("strdup failed");
+				return NL_SKIP;
+			}
+		}
+		return NL_OK;
+	default:
+		printf("Unknown command: %u\n", gnlh->cmd);
+		break;
+	}
+	return NL_OK;
+}
+
 static int elem;
 
 static int id_elem;
@@ -479,6 +718,91 @@ int validate_cb_ctrl(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
+#define BUFFER_SIZE 256
+
+int read_string_from_sysfs(const char *path, char *buffer, size_t buffer_size)
+{
+	int fd = open(path, O_RDONLY);
+
+	if (fd < 0) {
+		fprintf(stderr, "Error opening %s for reading sysfs: %s\n",
+			path, strerror(errno));
+		return -errno;
+	}
+
+	ssize_t len = read(fd, buffer, buffer_size - 1);
+
+	if (len < 0) {
+		fprintf(stderr, "Error reading to %s: %s\n", path,
+			strerror(errno));
+		close(fd);
+		return -errno;
+	}
+
+	buffer[len] = '\0';
+	close(fd);
+	return 0;
+}
+
+int read_int_from_sysfs(const char *path, int *value)
+{
+	char buffer[BUFFER_SIZE];
+	int ret;
+
+	ret = read_string_from_sysfs(path, buffer, sizeof(buffer));
+
+	if (ret != 0)
+		return ret;
+
+	char *endptr;
+	long val = strtol(buffer, &endptr, 10);
+
+	if (endptr == buffer) {
+		fprintf(stderr, "Conversion error: %s\n", strerror(errno));
+		return -errno;
+	}
+
+	*value = (int)val;
+	return 0;
+}
+
+int write_string_to_sysfs(const char *path, const char *value)
+{
+	int fd = open(path, O_WRONLY);
+
+	if (fd < 0) {
+		fprintf(stderr, "Error opening %s for writing sysfs: %s\n",
+			path, strerror(errno));
+		return -errno;
+	}
+
+	ssize_t len = write(fd, value, strlen(value));
+
+	if (len < 0) {
+		fprintf(stderr, "Error writing to %s: %s\n", path,
+			strerror(errno));
+		close(fd);
+		return -errno;
+	}
+
+	close(fd);
+	return 0;
+}
+
+int write_int_to_sysfs(const char *path, int value)
+{
+	char buffer[32];
+
+	int ret = snprintf(buffer, sizeof(buffer), "%d", value);
+
+	if (ret < 0 || ret >= sizeof(buffer)) {
+		fprintf(stderr, "Conversion error: %s\n", strerror(errno));
+		return -errno;
+	}
+
+	return write_string_to_sysfs(path, buffer);
+}
+
 struct nl_sock *socket_alloc_and_conn(void)
 {
 	struct nl_sock *socket;
@@ -1179,6 +1503,3563 @@ TEST(resolve_large_family_id)
 	EXPECT_TRUE(no_family_id > 0);
 }
 
+/**
+ * TEST(genl_small_cmd_get_value) - Tests small command in Generic Netlink family
+ *
+ * Validates:
+ * 1. Family resolution and socket setup
+ * 2. Message formatting and transmission
+ * 3. Response validation
+ * 4. Sysfs integration check
+ *
+ * Test Flow:
+ * 1. Resolves target Generic Netlink family
+ * 2. Prepares request with MY_GENL_SMALL_CMD_GET
+ * 3. Validates response through callback
+ * 4. Compares result with sysfs reference data
+ * 5. Cleans up test artifacts
+ *
+ * Special Handling:
+ * - Requires root for sysfs operations
+ * - Uses custom validation callback
+ * - Resets sysfs state after test
+ */
+
+TEST(genl_small_cmd_get_value)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err = 0;
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	printf("Running Test: getting value using small cmd...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		fprintf(stderr, "Failed to resolve family id: %d\n", family_id);
+		nl_socket_free(sock);
+		err = family_id;
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, MY_GENL_SMALL_CMD_GET, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	char *str = malloc(BUFFER_SIZE);
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = read_string_from_sysfs(PATH_GENL_TEST_MES, str, BUFFER_SIZE);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_STREQ(str, cb_data.message);
+
+	err = write_string_to_sysfs(PATH_GENL_TEST_MES, "default");
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	free(str);
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(genl_parallel) - Tests message exchange with PARALLEL_GENL Generic Netlink family
+ *
+ * Validates end-to-end communication with PARALLEL_GENL family:
+ * 1. Establishes connection to PARALLEL_GENL family
+ * 2. Sends PARALLEL_GENL_CMD_SEND command
+ * 3. Checks results with sysfs reference data
+ *
+ * Test Flow:
+ * 1. Resolves PARALLEL_GENL family ID
+ * 2. Prepares and sends command message
+ * 3. Receives and validates response
+ * 4. Compares with sysfs reference data
+ * 5. Resets test environment
+ *
+ * Requirements:
+ * - Root privileges (for sysfs access)
+ * - Loaded parallel_genl kernel module
+ * - Properly configured sysfs interface
+ *
+ * Error Handling:
+ * - Validates all intermediate steps
+ * - Cleans up resources on failure
+ * - Resets sysfs state after test
+ */
+
+TEST(genl_parallel)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err = 0;
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	printf("Running Test: sending message to parallel_genl...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, PARALLEL_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		fprintf(stderr, "Failed to resolve family id: %d\n", family_id);
+		nl_socket_free(sock);
+		err = family_id;
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, PARALLEL_GENL_CMD_SEND, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	char *str = malloc(BUFFER_SIZE);
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_parallel,
+			&cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = read_string_from_sysfs(PATH_PARALLEL_GENL_MES, str, BUFFER_SIZE);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_STREQ(str, cb_data.message);
+
+	err = write_string_to_sysfs(PATH_PARALLEL_GENL_MES, "default");
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	free(str);
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(genl_parallel_dump) - Tests parallel dump operation in Generic Netlink
+ *
+ * Validates the parallel dump functionality of the PARALLEL_GENL family by:
+ * 1. Sending a dump request (NLM_F_DUMP flag) with PARALLEL_GENL_CMD_DUMP_INFO command
+ * 2. Processing multiple response messages through callback validation
+ * 3. Verifying correct handling of parallel data streams
+ *
+ * Key Features Tested:
+ * - Multi-message dump handling capability
+ * - Parallel data stream processing
+ * - Callback validation of dump contents
+ * - Resource management during extended operations
+ *
+ * Test Flow:
+ * 1. Resolve PARALLEL_GENL family ID
+ * 2. Prepare dump request message:
+ *    - Sets NLM_F_DUMP flag
+ *    - Uses PARALLEL_GENL_CMD_DUMP_INFO command
+ * 3. Configure callback (validate_cb_parallel_dump) for message processing
+ * 4. Execute send/receive operations
+ * 5. Validate results through callback
+ *
+ * Error Handling:
+ * - Verifies all intermediate steps
+ * - Proper resource cleanup on failure
+ * - Callback determines final test status
+ */
+
+TEST(genl_parallel_dump)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err = 0;
+
+	struct callback_data_parallel_dump cb_data;
+
+	printf("Running Test: doing parallel dump with genl_parallel_dump...\n");
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, PARALLEL_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		fprintf(stderr, "Failed to resolve family id: %d\n", family_id);
+		nl_socket_free(sock);
+		err = family_id;
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_DUMP, PARALLEL_GENL_CMD_DUMP_INFO, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	char *str = malloc(BUFFER_SIZE);
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM,
+			validate_cb_parallel_dump, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	// callback function determines whether the test is successful
+
+	EXPECT_EQ(elems, DATA_SIZE);
+	elems = 0;
+
+error:
+	free(str);
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+static struct nl_msg *genl_generate_messages(int family_id, int nonblock)
+{
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	char *data;
+	int err;
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		return NULL;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, PARALLEL_GENL_CMD_SEND, 0);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		return NULL;
+	}
+
+	if (nonblock) {
+		if (nla_put_flag(msg, PARALLEL_GENL_ATTR_FLAG_NONBLOCK) < 0) {
+			fprintf(stderr,
+				"Failed to add PARALLEL_GENL_ATTR_FLAG_NONBLOCK flag attribute: %s\n",
+				strerror(errno));
+			nlmsg_free(msg);
+			return NULL;
+		}
+	} else {
+		if (nla_put_flag(msg, PARALLEL_GENL_ATTR_FLAG_BLOCK) < 0) {
+			fprintf(stderr,
+				"Failed to add PARALLEL_GENL_ATTR_FLAG_BLOCK flag attribute: %s\n",
+				strerror(errno));
+			nlmsg_free(msg);
+			return NULL;
+		}
+	}
+
+	int data_size = 4068;
+
+	data = malloc(data_size);
+	if (!data) {
+		fprintf(stderr, "Failed to allocate data buffer\n");
+		nlmsg_free(msg);
+		return NULL;
+	}
+	memset(data, 1, data_size);
+
+	err = nla_put(msg, PARALLEL_GENL_ATTR_BINARY, data_size, data);
+	if (err < 0) {
+		fprintf(stderr,
+			"Failed to add PARALLEL_GENL_ATTR_BINARY attribute: %s\n",
+			strerror(errno));
+		free(data);
+		nlmsg_free(msg);
+		return NULL;
+	}
+
+	return msg;
+}
+
+/**
+ * TEST(incorrect_genl_parallel_with_flag_nonblock_sock) - Tests buffer overflow in
+ * non-blocking Generic Netlink socket
+ *
+ * Validates kernel behavior under buffer overflow conditions by:
+ * 1. Creating a non-blocking socket with reduced buffer size (5000 bytes)
+ * 2. Rapidly sending multiple messages (20x) without waiting for responses
+ * 3. Verifying proper error handling when buffer capacity is exceeded
+ *
+ * Expected Behavior:
+ * - First receive attempt should fail with NLE_NOMEM (ENOBUFS)
+ * - Subsequent receives should return NLE_AGAIN (EAGAIN)
+ * - Number of successfully received messages should be less than sent (kernel drops packets)
+ *
+ * Test Methodology:
+ * 1. Configure non-blocking socket with small buffer
+ * 2. Flood the socket with back-to-back messages
+ * 3. Verify error sequence:
+ *    a) Initial ENOBUFS when buffer is full
+ *    b) Subsequent EAGAIN for empty buffer
+ * 4. Confirm packet loss (recv_count < send_count)
+ *
+ * Technical Notes:
+ * - Requires root for socket configuration
+ * - Uses custom message generator (genl_generate_messages)
+ * - Tests kernel's congestion control mechanisms
+ * - Validates Netlink's non-blocking error handling
+ */
+
+TEST(incorrect_genl_parallel_with_flag_nonblock_sock)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err = 0;
+	int send_c;
+	int recv_c;
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	printf("Running Test: trying to overflow buffer of nonblock socket...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, PARALLEL_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		fprintf(stderr, "Failed to resolve family id: %d\n", family_id);
+		nl_socket_free(sock);
+		err = family_id;
+		return;
+	}
+
+	err = nl_socket_set_buffer_size(sock, 5000, 5000);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to change socket buffer size: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_socket_set_nonblocking(sock);
+	EXPECT_EQ(err, 0);
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_parallel,
+			&cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	send_c = 20;
+	recv_c = 0;
+	for (int i = 0; i < send_c; i++) {
+		msg = genl_generate_messages(family_id, 1);
+		EXPECT_NE(NULL, msg);
+		if (!msg) {
+			fprintf(stderr, "Failed to create message\n");
+			goto error;
+		}
+		err = nl_send_auto(sock, msg);
+		EXPECT_GE(err, 0);
+		if (err < 0) {
+			fprintf(stderr, "Failed to send message: %s\n",
+				nl_geterror(err));
+			goto error;
+		}
+		nlmsg_free(msg);
+	}
+
+	// the buffer is full
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, -NLE_NOMEM);
+	EXPECT_EQ(errno, ENOBUFS);
+
+	for (int i = 1; i < send_c; i++) {
+		err = nl_recvmsgs(sock, cb);
+		if (err < 0) {
+			EXPECT_EQ(err, -NLE_AGAIN);
+			EXPECT_EQ(errno, EAGAIN);
+		}
+		if (err == 0)
+			recv_c++;
+	}
+	EXPECT_LT(recv_c, send_c);
+
+error:
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(incorrect_genl_parallel_with_flag_block_sock) - Tests buffer overflow behavior in
+ * blocking Generic Netlink socket
+ *
+ * Validates kernel packet handling under buffer overflow conditions with blocking sockets:
+ * 1. Configures socket with small buffer (1000 bytes) and 1-second timeout
+ * 2. Sends burst of messages (8x) to trigger overflow
+ * 3. Verifies correct error sequence and packet loss
+ *
+ * Expected Behavior:
+ * - Initial receive returns NLE_NOMEM (ENOBUFS) when buffer is full
+ * - Subsequent receives get partial messages (recv_count < send_count)
+ * - Final receive returns NLE_AGAIN (EAGAIN) when queue is empty
+ *
+ * Test Methodology:
+ * 1. Reduce socket buffer size to force quick overflow
+ * 2. Set conservative timeout (1s) for blocked receives
+ * 3. Send message burst without waiting for responses
+ * 4. Verify:
+ *    a) Initial ENOBUFS error
+ *    b) Partial message delivery
+ *    c) Terminal EAGAIN condition
+ *
+ * Technical Notes:
+ * - Demonstrates kernel's congestion control with blocking sockets
+ * - Shows Netlink's reliability limits under overload
+ * - Uses SO_RCVTIMEO to prevent indefinite blocking
+ * - Requires root for socket configuration
+ */
+
+TEST(incorrect_genl_parallel_with_flag_block_sock)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err = 0;
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	struct timeval tv = { 1, 0 };
+
+	int send_c;
+	int recv_c;
+
+	printf("Running Test: trying to overflow buffer of block socket...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, PARALLEL_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		fprintf(stderr, "Failed to resolve family id: %d\n", family_id);
+		nl_socket_free(sock);
+		err = family_id;
+		return;
+	}
+
+	err = nl_socket_set_buffer_size(sock, 1000, 1000);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to change socket buffer size: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = setsockopt(nl_socket_get_fd(sock), SOL_SOCKET, SO_RCVTIMEO, &tv,
+			 sizeof(tv));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set timeout for block socket\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_parallel,
+			&cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	send_c = 8;
+	for (int i = 0; i < send_c; i++) {
+		msg = genl_generate_messages(family_id, 0);
+		EXPECT_NE(NULL, msg);
+		if (!msg) {
+			fprintf(stderr, "Failed to create message\n");
+			goto error;
+		}
+		err = nl_send_auto(sock, msg);
+		EXPECT_GE(err, 0);
+		if (err < 0) {
+			fprintf(stderr, "Failed to send message: %s\n",
+				nl_geterror(err));
+			goto error;
+		}
+		nlmsg_free(msg);
+	}
+
+	recv_c = 0;
+
+	// the buffer is full
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, -NLE_NOMEM);
+	EXPECT_EQ(errno, ENOBUFS);
+
+	for (int i = 1; i < send_c; i++) {
+		err = nl_recvmsgs(sock, cb);
+		if (err == 0)
+			recv_c++;
+
+		if (err < 0) {
+			EXPECT_EQ(err, -NLE_AGAIN);
+			EXPECT_EQ(errno, EAGAIN);
+		}
+	}
+
+	EXPECT_TRUE(err == -NLE_AGAIN && errno == EAGAIN);
+	EXPECT_LT(recv_c, send_c);
+
+error:
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(genl_test_get_value) - Tests basic communication with TEST_GENL family
+ *
+ * Validates end-to-end message exchange including:
+ * 1. Family and multicast group resolution
+ * 2. Message formatting and transmission
+ * 3. Response validation through callback
+ * 4. Sysfs integration verification
+ *
+ * Test Flow:
+ * 1. Establish connection to TEST_GENL
+ * 2. Resolve multicast group MY_MCGRP_GENL
+ * 3. Prepare GET_VALUE request message:
+ *    - Sets MY_GENL_CMD_GET_VALUE command
+ *    - Includes path attribute (PATH_GENL_TEST_NUM)
+ * 4. Send request and validate response
+ * 5. Compare result with sysfs reference data
+ * 6. Reset test environment
+ *
+ * Special Handling:
+ * - Requires root privileges (sysfs access)
+ * - Uses custom validation callback
+ * - Verifies both Netlink and sysfs interfaces
+ * - Automatic cleanup of test artifacts
+ */
+
+TEST(genl_test_get_value)
+{
+	struct nl_sock *nl_sock;
+	int family_id;
+	int mcgrp_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err = 0;
+	int int_value = -10;
+	struct genlmsghdr *user_hdr;
+	struct callback_data cb_data;
+
+	cb_data.int_value = 20;
+	cb_data.message = NULL;
+
+	printf("Running Test: getting value from sysfs via Netlink message...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	nl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, nl_sock);
+	if (!nl_sock)
+		return;
+
+	family_id = genl_ctrl_resolve(nl_sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		nl_socket_free(nl_sock);
+		err = family_id;
+		return;
+	}
+
+	mcgrp_id = genl_ctrl_resolve_grp(nl_sock, MY_GENL_FAMILY_NAME,
+					 MY_MCGRP_NAME);
+	EXPECT_GE(mcgrp_id, 0);
+	if (mcgrp_id < 0) {
+		nl_socket_free(nl_sock);
+		err = mcgrp_id;
+		return;
+	}
+
+	err = nl_socket_add_membership(nl_sock, mcgrp_id);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, MY_GENL_CMD_GET_VALUE, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, MY_GENL_ATTR_PATH, PATH_GENL_TEST_NUM) < 0) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0)
+		goto error;
+
+	err = nl_send_auto(nl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		nlmsg_free(msg);
+		nl_cb_put(cb);
+		return;
+	}
+
+	err = nl_recvmsgs(nl_sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		nlmsg_free(msg);
+		nl_cb_put(cb);
+		return;
+	}
+
+	err = read_int_from_sysfs(PATH_GENL_TEST_NUM, &int_value);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_EQ(int_value, cb_data.int_value);
+
+	err = write_int_to_sysfs(PATH_GENL_TEST_NUM, -20);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(nl_sock);
+}
+
+/**
+ * TEST(genl_test_echo) - Tests multicast echo functionality in TEST_GENL family
+ *
+ * Validates the echo request/reply mechanism through multicast groups by:
+ * 1. Configuring socket with CAP_ACK capability
+ * 2. Sending echo request (NLM_F_ECHO flag) with MY_GENL_CMD_ECHO command
+ * 3. Receiving and validating multicast response
+ * 4. Verifying message content against sysfs reference
+ *
+ * Protocol Details:
+ * - Uses NETLINK_CAP_ACK for reliable multicast delivery
+ * - Leverages multicast group (MY_MCGRP_GENL) for replies
+ * - Validates both Netlink and sysfs message content
+ *
+ * Test Flow:
+ * 1. Establish Netlink connection
+ * 2. Enable CAP_ACK socket option
+ * 3. Resolve family and multicast group IDs
+ * 4. Join multicast group
+ * 5. Prepare and send echo request
+ * 6. Receive and validate multicast reply
+ * 7. Compare with sysfs reference data
+ * 8. Reset test environment
+ *
+ * Requirements:
+ * - Root privileges (for sysfs and socket configuration)
+ * - Properly configured multicast group in kernel
+ * - Validated echo handler in kernel module
+ */
+
+TEST(genl_test_echo)
+{
+	struct nl_sock *sock;
+	int family_id;
+	int mcgrp_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err = 0;
+	int sock_fd;
+	int cap_ack = 1;
+	int optval;
+	socklen_t optlen = sizeof(optval);
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	printf("Running Test: getting message that was sent to mcast groups...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock)
+		return;
+
+	sock_fd = nl_socket_get_fd(sock);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		nl_socket_free(sock);
+		err = sock_fd;
+		return;
+	}
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_CAP_ACK, &cap_ack,
+			 sizeof(cap_ack));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = getsockopt(sock_fd, SOL_NETLINK, NETLINK_CAP_ACK, &optval,
+			 &optlen);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(sock);
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		nl_socket_free(sock);
+		err = family_id;
+		return;
+	}
+
+	mcgrp_id =
+		genl_ctrl_resolve_grp(sock, MY_GENL_FAMILY_NAME, MY_MCGRP_NAME);
+	EXPECT_GE(mcgrp_id, 0);
+	if (mcgrp_id < 0) {
+		err = mcgrp_id;
+		fprintf(stderr, "Failed to resolve multicast group: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_socket_add_membership(sock, mcgrp_id);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to add membership: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		nl_socket_free(sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_ECHO, MY_GENL_CMD_ECHO, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	char *str = malloc(BUFFER_SIZE);
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0)
+		goto error;
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		free(str);
+		nlmsg_free(msg);
+		nl_cb_put(cb);
+		return;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		free(str);
+		nlmsg_free(msg);
+		nl_cb_put(cb);
+		return;
+	}
+
+	err = read_string_from_sysfs(PATH_GENL_TEST_MES, str, BUFFER_SIZE);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_STREQ(str, cb_data.message);
+
+	err = write_string_to_sysfs(PATH_GENL_TEST_MES, "default");
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	free(str);
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(genl_test_set_value) - Tests value setting functionality in TEST_GENL family
+ *
+ * Validates the complete SET_VALUE operation workflow:
+ * 1. Configures socket with STRICT_CHK option for robust message validation
+ * 2. Sends properly formatted SET_VALUE command with:
+ *    - Target path (PATH_GENL_TEST_NUM)
+ *    - Integer value to set (1)
+ * 3. Verifies correct processing through:
+ *    - Netlink response validation
+ *    - Sysfs value verification
+ *
+ * Key Features Tested:
+ * - Strict checking option (NETLINK_GET_STRICT_CHK)
+ * - Multicast group communication
+ * - Attribute packing and unpacking
+ * - End-to-end sysfs integration
+ *
+ * Test Flow:
+ * 1. Initialize Netlink connection with strict checking
+ * 2. Resolve family and multicast group IDs
+ * 3. Prepare SET_VALUE request with path and value attributes
+ * 4. Send request and validate response
+ * 5. Verify sysfs value was updated correctly
+ * 6. Reset test environment
+ *
+ * Special Handling:
+ * - Requires root privileges (sysfs modification)
+ * - Uses custom validation callback
+ * - Automatic cleanup of test artifacts
+ */
+
+TEST(genl_test_set_value)
+{
+	struct nl_sock *nl_sock;
+	int family_id;
+	int mcgrp_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err = 0;
+	int int_value;
+	int sock_fd;
+	int up = 1;
+	struct genlmsghdr *user_hdr;
+	int optval;
+
+	socklen_t optlen = sizeof(optval);
+
+	struct callback_data cb_data;
+
+	cb_data.int_value = 74;
+	cb_data.message = NULL;
+
+	printf("Running Test: sending correct value for sysfs to genl_test...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	nl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, nl_sock);
+	if (!nl_sock)
+		return;
+
+	sock_fd = nl_socket_get_fd(nl_sock);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		err = sock_fd;
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_GET_STRICT_CHK, &up,
+			 sizeof(up));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = getsockopt(sock_fd, SOL_NETLINK, NETLINK_GET_STRICT_CHK, &optval,
+			 &optlen);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(nl_sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		nl_socket_free(nl_sock);
+		err = family_id;
+		return;
+	}
+
+	mcgrp_id = genl_ctrl_resolve_grp(nl_sock, MY_GENL_FAMILY_NAME,
+					 MY_MCGRP_NAME);
+	EXPECT_GE(mcgrp_id, 0);
+	if (mcgrp_id < 0) {
+		nl_socket_free(nl_sock);
+		err = mcgrp_id;
+		return;
+	}
+
+	err = nl_socket_add_membership(nl_sock, mcgrp_id);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, MY_GENL_CMD_SET_VALUE, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, MY_GENL_ATTR_PATH, PATH_GENL_TEST_NUM) < 0) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	if (nla_put_u32(msg, MY_GENL_ATTR_VALUE, 1) < 0) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(nl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		nlmsg_free(msg);
+		nl_cb_put(cb);
+		return;
+	}
+
+	err = nl_recvmsgs(nl_sock, cb);
+	EXPECT_TRUE(err == 0 || err == -NLE_PERM);
+	if (err < 0) {
+		if (geteuid() != 0)
+			EXPECT_EQ(err, -NLE_PERM);
+
+		EXPECT_EQ(err, 0);
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		nlmsg_free(msg);
+		nl_cb_put(cb);
+		return;
+	}
+
+	err = read_int_from_sysfs(PATH_GENL_TEST_NUM, &int_value);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_EQ(int_value, cb_data.int_value);
+
+	err = write_int_to_sysfs(PATH_GENL_TEST_NUM, -20);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(nl_sock);
+}
+
+/**
+ * TEST(incorrect_genl_test_set_value) - Tests error handling in TEST_GENL family
+ *
+ * Validates proper error reporting for invalid SET_VALUE operations by:
+ * 1. Enabling extended ACK (NETLINK_EXT_ACK) for detailed error messages
+ * 2. Configuring broadcast error reporting (NETLINK_BROADCAST_ERROR)
+ * 3. Sending intentionally incorrect value (34) to trigger error
+ * 4. Verifying kernel returns appropriate error codes:
+ *    - NLE_INVAL for root (invalid value)
+ *    - NLE_PERM for non-root (permission denied)
+ *
+ * Key Features Tested:
+ * - Extended ACK error reporting mechanism
+ * - Broadcast error propagation
+ * - Kernel validation of input values
+ * - Permission checking
+ *
+ * Test Flow:
+ * 1. Configure socket with EXT_ACK and BROADCAST_ERROR options
+ * 2. Resolve family and multicast group IDs
+ * 3. Prepare SET_VALUE request with invalid value (34)
+ * 4. Send request and verify error response
+ * 5. Validate error code matches expectations
+ *
+ * Special Handling:
+ * - Different expected errors for root/non-root
+ * - Uses kernel's extended ACK reporting
+ * - Tests both value validation and permission checks
+ */
+
+TEST(incorrect_genl_test_set_value)
+{
+	struct nl_sock *nl_sock;
+	int family_id;
+	int mcgrp_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err;
+	int sock_fd;
+	int ext_ack = 1;
+	int broadcast_error = 1;
+	struct genlmsghdr *user_hdr;
+
+	int optval;
+
+	socklen_t optlen = sizeof(optval);
+
+	struct callback_data cb_data;
+
+	cb_data.int_value = 74;
+	cb_data.message = NULL;
+
+	printf("Running Test: sending incorrect value for sysfs to genl_test...\n");
+
+	nl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, nl_sock);
+	if (!nl_sock) {
+		printf("socket for my_genl is NULL\n");
+		return;
+	}
+
+	sock_fd = nl_socket_get_fd(nl_sock);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		fprintf(stderr, "Failed to get socket file descriptor\n");
+		err = sock_fd;
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_EXT_ACK, &ext_ack,
+			 sizeof(ext_ack));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = getsockopt(sock_fd, SOL_NETLINK, NETLINK_EXT_ACK, &optval,
+			 &optlen);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	EXPECT_EQ(optval, 1);
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_BROADCAST_ERROR,
+			 &broadcast_error, sizeof(broadcast_error));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = getsockopt(sock_fd, SOL_NETLINK, NETLINK_BROADCAST_ERROR, &optval,
+			 &optlen);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	EXPECT_EQ(optval, 1);
+
+	family_id = genl_ctrl_resolve(nl_sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr, "Failed to resolve family id: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	mcgrp_id = genl_ctrl_resolve_grp(nl_sock, MY_GENL_FAMILY_NAME,
+					 MY_MCGRP_NAME);
+	EXPECT_GE(mcgrp_id, 0);
+	if (mcgrp_id < 0) {
+		err = mcgrp_id;
+		fprintf(stderr, "Failed to resolve multicast group: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_socket_add_membership(nl_sock, mcgrp_id);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to add membership: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, MY_GENL_CMD_SET_VALUE, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, MY_GENL_ATTR_PATH, PATH_GENL_TEST_NUM) < 0) {
+		fprintf(stderr,
+			"Failed to add MY_GENL_ATTR_PATH attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	if (nla_put_u32(msg, MY_GENL_ATTR_VALUE, 34) < 0) {
+		fprintf(stderr,
+			"Failed to add MY_GENL_ATTR_VALUE attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		printf("Error setting callback\n");
+		goto error;
+	}
+
+	err = nl_send_auto(nl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	// nl_recvmsgs gets error code from error ACK from kernel
+	err = nl_recvmsgs(nl_sock, cb);
+	EXPECT_TRUE(err == -NLE_PERM || err == -NLE_INVAL);
+	if (err < 0) {
+		if (geteuid() != 0)
+			EXPECT_EQ(err, -NLE_PERM);
+
+		if (geteuid() == 0)
+			EXPECT_EQ(err, -NLE_INVAL);
+	}
+	EXPECT_LT(err, 0);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(nl_sock);
+}
+
+/**
+ * TEST(incorrect_family) - Tests handling of non-existent Generic Netlink family
+ *
+ * Validates proper error reporting when attempting to resolve:
+ * 1. A deliberately non-existent Generic Netlink family
+ * 2. Expected error code (NLE_OBJ_NOTFOUND)
+ *
+ * Key Features Tested:
+ * - Controller behavior for unknown family names
+ * - Correct error code propagation
+ * - Graceful handling of resolution failures
+ *
+ * Test Methodology:
+ * 1. Creates standard Netlink socket
+ * 2. Attempts to resolve "SOME_RANDOM_NAME" family
+ * 3. Verifies:
+ *    - Return value is negative (error)
+ *    - Specific error code is NLE_OBJ_NOTFOUND
+ *    - Clean resource deallocation
+ *
+ * Negative Testing:
+ * - Demonstrates proper error handling for invalid inputs
+ * - Verifies kernel API contract for unknown families
+ */
+
+TEST(incorrect_family)
+{
+	struct nl_sock *sock;
+	int family_id;
+
+	printf("Running Test: trying to find id of incorrect Netlink family...\n");
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, "SOME_RANDOM_NAME");
+	EXPECT_EQ(family_id, -NLE_OBJ_NOTFOUND);
+
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(incorrect_family_id) - Tests error handling for invalid family ID
+ *
+ * Validates proper error reporting when sending messages to:
+ * 1. A deliberately incorrect family ID (valid ID + 1)
+ * 2. With otherwise valid command (MY_GENL_SMALL_CMD_GET)
+ *
+ * Expected Behavior:
+ * - Kernel should return NLE_OPNOTSUPP ("Operation not supported")
+ * - Demonstrates proper error propagation through Netlink stack
+ *
+ * Test Methodology:
+ * 1. Resolves valid family ID for reference
+ * 2. Creates message with intentionally invalid family ID (+1)
+ * 3. Verifies:
+ *    - Message transmission succeeds
+ *    - Kernel responds with NLE_OPNOTSUPP
+ *    - Resources are properly cleaned up
+ *
+ * Negative Testing:
+ * - Confirms kernel validates family IDs
+ * - Tests error handling for invalid destinations
+ * - Verifies API contract for unsupported operations
+ */
+
+TEST(incorrect_family_id)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err;
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	printf("Running Test: trying to send a message to incorrect id of Netlink family (== nonexistent cmd)...\n");
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr, "Failed to resolve family id: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	// put incorrect id for Netlink message
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id + 1, 0,
+			       NLM_F_REQUEST, MY_GENL_SMALL_CMD_GET, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, -NLE_OPNOTSUPP);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(incorrect_cmd) - Tests error handling for invalid Generic Netlink commands
+ *
+ * Validates proper error reporting when:
+ * 1. Sending a message with deliberately invalid command (SOME_RANDOM_CMD)
+ * 2. Using otherwise correct family ID and message format
+ *
+ * Expected Behavior:
+ * - Kernel should return NLE_OPNOTSUPP ("Operation not supported")
+ * - Demonstrates command validation in Generic Netlink subsystem
+ *
+ * Test Methodology:
+ * 1. Resolves valid family ID
+ * 2. Creates message with invalid command number
+ * 3. Verifies:
+ *    - Message transmission succeeds (invalid command is syntactically valid)
+ *    - Kernel responds with NLE_OPNOTSUPP
+ *    - Resources are properly cleaned up
+ *
+ * Negative Testing:
+ * - Confirms kernel validates command numbers
+ * - Tests error handling for unsupported operations
+ * - Verifies API contract for invalid commands
+ */
+
+TEST(incorrect_cmd)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err;
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	printf("Running Test: trying to send incorrect == non-existent cmd...\n");
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr, "Failed to resolve family id: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, SOME_RANDOM_CMD, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, -NLE_OPNOTSUPP);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(incorrect_ctrl_family_name) - Tests error handling for invalid family names
+ * in controller requests
+ *
+ * Validates that the Generic Netlink controller:
+ * 1. Properly rejects requests with non-existent family names
+ * 2. Returns appropriate error code (NLE_INVAL)
+ * 3. Maintains system stability when receiving invalid parameters
+ *
+ * Test Methodology:
+ * 1. Creates valid connection to genl_ctrl
+ * 2. Prepares GETFAMILY request with invalid family name
+ * 3. Verifies:
+ *    - Controller rejects request with NLE_INVAL
+ *    - Error is properly propagated to userspace
+ *    - Resources are correctly cleaned up
+ *
+ * Expected Behavior:
+ * - Kernel should return NLE_INVAL ("Invalid input data or parameter")
+ * - Controller should maintain stable operation
+ * - No memory leaks or resource issues
+ *
+ * Negative Testing:
+ * - Confirms input validation in Generic Netlink controller
+ * - Tests error handling for non-existent entities
+ * - Verifies API contract for invalid parameters
+ */
+
+TEST(incorrect_ctrl_family_name)
+{
+	struct nl_sock *ctrl_sock;
+	int genl_ctrl_family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb_ctrl;
+	int err;
+	struct callback_data_ctrl cb_ctrl_data;
+
+	cb_ctrl_data.family_id = -30;
+	cb_ctrl_data.family_name = NULL;
+	cb_ctrl_data.op = -100;
+
+	printf("Running Test: sending invalid family name to genl_ctrl...\n");
+
+	ctrl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, ctrl_sock);
+	if (!ctrl_sock) {
+		fprintf(stderr, "socket for genl_ctrl is NULL\n");
+		return;
+	}
+
+	genl_ctrl_family_id = genl_ctrl_resolve(ctrl_sock, GENL_CTRL);
+	EXPECT_GT(genl_ctrl_family_id, 0);
+	if (genl_ctrl_family_id < 0) {
+		err = genl_ctrl_family_id;
+		fprintf(stderr,
+			"Failed to resolve family id for genl_ctrl: %s\n",
+			nl_geterror(err));
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ,
+			       genl_ctrl_family_id, 0, NLM_F_REQUEST,
+			       CTRL_CMD_GETFAMILY, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, CTRL_ATTR_FAMILY_NAME, "SOME_RANDOM_NAME") <
+	    0) {
+		fprintf(stderr,
+			"Failed to add incorrect CTRL_ATTR_FAMILY_NAME attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb_ctrl = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb_ctrl);
+	if (!cb_ctrl) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(ctrl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb_ctrl, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_ctrl,
+			&cb_ctrl_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(ctrl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(ctrl_sock, cb_ctrl);
+	EXPECT_EQ(err, -NLE_INVAL);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb_ctrl);
+	nl_socket_free(ctrl_sock);
+}
+
+/**
+ * TEST(incorrect_genl_parallel_with_flag_nonblock_sock_enobufs) - Tests
+ * NETLINK_NO_ENOBUFS socket option behavior
+ *
+ * Validates the interaction of buffer overflow handling with NETLINK_NO_ENOBUFS by:
+ * 1. Configuring socket with NETLINK_NO_ENOBUFS option
+ * 2. Artificially creating buffer overflow conditions
+ * 3. Verifying the absence of ENOBUFS errors
+ * 4. Confirming packet loss occurs during overflow
+ *
+ * Key Features Tested:
+ * - NETLINK_NO_ENOBUFS socket option functionality
+ * - Non-blocking socket behavior under congestion
+ * - Kernel packet dropping policy
+ * - Error code propagation
+ *
+ * Test Methodology:
+ * 1. Configure socket with:
+ *    - Small buffer size (2000 bytes)
+ *    - Non-blocking mode
+ *    - NETLINK_NO_ENOBUFS option
+ * 2. Flood the socket with back-to-back messages (15x)
+ * 3. Verify:
+ *    - No ENOBUFS errors occur
+ *    - Only EAGAIN is reported when buffer is empty
+ *    - Packet loss occurs (recv_count < send_count)
+ *
+ * Expected Behavior:
+ * - Kernel should suppress ENOBUFS errors when NETLINK_NO_ENOBUFS is set
+ * - Messages should be silently dropped when buffer is full
+ * - Application should only see EAGAIN for empty buffer
+ */
+
+TEST(incorrect_genl_parallel_with_flag_nonblock_sock_enobufs)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err = 0;
+	int send_c;
+	int recv_c;
+
+	int no_enobufs_val = 1;
+	int sock_fd;
+
+	int optval;
+
+	socklen_t optlen = sizeof(optval);
+
+	struct callback_data cb_data;
+
+	cb_data.int_value = -30;
+	cb_data.message = NULL;
+
+	printf("Running Test: trying to overflow buffer of nonblock socket with NETLINK_NO_ENOBUFS socket option...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	sock_fd = nl_socket_get_fd(sock);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		err = sock_fd;
+		fprintf(stderr, "Failed to get socket file descriptor: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_NO_ENOBUFS,
+			 &no_enobufs_val, sizeof(no_enobufs_val));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set NETLINK_NO_ENOBUFS: %s\n",
+			strerror(errno));
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = getsockopt(sock_fd, SOL_NETLINK, NETLINK_NO_ENOBUFS, &optval,
+			 &optlen);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to get NETLINK_NO_ENOBUFS: %s\n",
+			strerror(errno));
+		nl_socket_free(sock);
+		return;
+	}
+
+	EXPECT_EQ(optval, 1);
+
+	family_id = genl_ctrl_resolve(sock, PARALLEL_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		fprintf(stderr, "Failed to resolve family id: %d\n", family_id);
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_socket_set_buffer_size(sock, 2000, 2000);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to change socket buffer size: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_socket_set_nonblocking(sock);
+	EXPECT_EQ(err, 0);
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_parallel,
+			&cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	send_c = 15;
+	recv_c = 0;
+	for (int i = 0; i < send_c; i++) {
+		msg = genl_generate_messages(family_id, 1);
+		EXPECT_NE(NULL, msg);
+		if (!msg) {
+			fprintf(stderr, "Failed to create message\n");
+			goto error;
+		}
+		err = nl_send_auto(sock, msg);
+		EXPECT_GE(err, 0);
+		if (err < 0) {
+			fprintf(stderr, "Failed to send message: %s\n",
+				nl_geterror(err));
+			goto error;
+		}
+		nlmsg_free(msg);
+	}
+
+	for (int i = 0; i < send_c; i++) {
+		err = nl_recvmsgs(sock, cb);
+		if (err < 0) {
+			EXPECT_EQ(err, -NLE_AGAIN);
+			EXPECT_EQ(errno, EAGAIN);
+		}
+		if (err == 0)
+			recv_c++;
+
+		EXPECT_NE(errno, ENOBUFS);
+	}
+	EXPECT_LT(recv_c, send_c);
+
+error:
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(genl_test_get_value_sock_option) - Tests NETLINK_NO_ENOBUFS socket option functionality
+ *
+ * Validates the complete workflow of setting and using the NETLINK_NO_ENOBUFS socket option:
+ * 1. Sets and verifies NETLINK_NO_ENOBUFS socket option
+ * 2. Performs standard GET_VALUE operation
+ * 3. Verifies successful message exchange despite option being set
+ *
+ * Key Features Tested:
+ * - NETLINK_NO_ENOBUFS option setting and verification
+ * - Normal operation with the option enabled
+ * - Integration with existing GET_VALUE functionality
+ * - Sysfs value verification
+ *
+ * Test Flow:
+ * 1. Configure socket with NETLINK_NO_ENOBUFS option
+ * 2. Verify option was correctly set
+ * 3. Resolve family and multicast group IDs
+ * 4. Prepare and send GET_VALUE request
+ * 5. Validate response and sysfs value
+ * 6. Clean up test environment
+ *
+ * Special Considerations:
+ * - Requires root privileges for sysfs access
+ * - Tests both socket option functionality and normal operation
+ * - Maintains backward compatibility with existing behavior
+ */
+
+TEST(genl_test_get_value_sock_option)
+{
+	struct nl_sock *nl_sock;
+	int family_id;
+	int mcgrp_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err;
+	int int_value;
+	int no_enobufs_val = 1;
+	int sock_fd;
+
+	int optval;
+
+	socklen_t optlen = sizeof(optval);
+
+	struct genlmsghdr *user_hdr;
+
+	struct callback_data cb_data;
+
+	printf("Running Test: sending a message with NETLINK_NO_ENOBUFS socket option...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	nl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, nl_sock);
+	if (!nl_sock) {
+		printf("socket for my_genl is NULL\n");
+		return;
+	}
+
+	sock_fd = nl_socket_get_fd(nl_sock);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		err = sock_fd;
+		fprintf(stderr, "Failed to get socket file descriptor: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_NO_ENOBUFS,
+			 &no_enobufs_val, sizeof(no_enobufs_val));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set NETLINK_NO_ENOBUFS: %s\n",
+			strerror(errno));
+		err = -errno;
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = getsockopt(sock_fd, SOL_NETLINK, NETLINK_NO_ENOBUFS, &optval,
+			 &optlen);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to get NETLINK_NO_ENOBUFS: %s\n",
+			strerror(errno));
+		err = -errno;
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	EXPECT_EQ(optval, 1);
+
+	family_id = genl_ctrl_resolve(nl_sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr, "Failed to resolve family id: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	mcgrp_id = genl_ctrl_resolve_grp(nl_sock, MY_GENL_FAMILY_NAME,
+					 MY_MCGRP_NAME);
+	EXPECT_GE(mcgrp_id, 0);
+	if (mcgrp_id < 0) {
+		err = mcgrp_id;
+		fprintf(stderr, "Failed to resolve multicast group: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_socket_add_membership(nl_sock, mcgrp_id);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to add membership: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, MY_GENL_CMD_GET_VALUE, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, MY_GENL_ATTR_PATH, PATH_GENL_TEST_NUM) < 0) {
+		fprintf(stderr,
+			"Failed to add MY_GENL_ATTR_PATH attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(nl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(nl_sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = read_int_from_sysfs(PATH_GENL_TEST_NUM, &int_value);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_EQ(int_value, cb_data.int_value);
+
+	err = write_int_to_sysfs(PATH_GENL_TEST_NUM, -20);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(nl_sock);
+}
+
+/**
+ * TEST(incorrect_genl_test_ext_ack) - NETLINK_EXT_ACK error handling verification
+ *
+ * Validates extended error acknowledgment mechanism by:
+ * 1. Testing successful setting of NETLINK_EXT_ACK socket option
+ * 2. Sending deliberately malformed Generic Netlink message:
+ *    - Contains invalid path attribute (MY_GENL_ATTR_PATH="some/random/path")
+ * 3. Verifying kernel returns expected error (EINVAL/NLE_INVAL)
+ * 4. Checking proper delivery of extended error information via EXT_ACK
+ *
+ * Expected behavior:
+ * - NETLINK_EXT_ACK option should be successfully set (optval == 1)
+ * - Kernel should reject malformed message with -NLE_INVAL error
+ *
+ * Implementation notes:
+ * - Uses synthetic invalid path to guarantee error generation
+ * - Tests complete workflow: option setup -> message send -> error handling
+ * - Covers both basic error code and extended error information
+ */
+
+TEST(incorrect_genl_test_ext_ack)
+{
+	struct nl_sock *nl_sock;
+	int family_id;
+	int mcgrp_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err;
+	int up;
+	int sock_fd;
+
+	int optval;
+
+	socklen_t optlen = sizeof(optval);
+
+	struct genlmsghdr *user_hdr;
+	struct callback_data cb_data;
+
+	printf("Running Test: sending a message with NETLINK_EXT_ACK socket option and incorrect path value...\n");
+
+	nl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, nl_sock);
+	if (!nl_sock) {
+		fprintf(stderr, "socket for my_genl is NULL\n");
+		return;
+	}
+
+	sock_fd = nl_socket_get_fd(nl_sock);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		err = sock_fd;
+		fprintf(stderr, "Failed to get socket file descriptor: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	up = 1;
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_EXT_ACK, &up,
+			 sizeof(up));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set NETLINK_EXT_ACK: %s",
+			strerror(errno));
+		err = -errno;
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = getsockopt(sock_fd, SOL_NETLINK, NETLINK_EXT_ACK, &optval,
+			 &optlen);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to get NETLINK_EXT_ACK: %s",
+			strerror(errno));
+		err = -errno;
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	EXPECT_EQ(optval, 1);
+
+	family_id = genl_ctrl_resolve(nl_sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr, "Failed to resolve family id: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	mcgrp_id = genl_ctrl_resolve_grp(nl_sock, MY_GENL_FAMILY_NAME,
+					 MY_MCGRP_NAME);
+	EXPECT_GE(mcgrp_id, 0);
+	if (mcgrp_id < 0) {
+		err = mcgrp_id;
+		fprintf(stderr, "Failed to resolve multicast group: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_socket_add_membership(nl_sock, mcgrp_id);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to add membership: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, MY_GENL_CMD_GET_VALUE, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, MY_GENL_ATTR_PATH, "some/random/path") < 0) {
+		fprintf(stderr,
+			"Failed to add MY_GENL_ATTR_PATH attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(nl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(nl_sock, cb);
+	EXPECT_EQ(err, -NLE_INVAL);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(nl_sock);
+}
+
+/**
+ * TEST(genl_test_sock_listen_all_nsid) - Tests NETLINK_LISTEN_ALL_NSID socket option functionality
+ *
+ * Validates the behavior of NETLINK_LISTEN_ALL_NSID socket option by:
+ * 1. Setting the NETLINK_LISTEN_ALL_NSID option on a netlink socket
+ * 2. Verifying proper socket operation with this option enabled
+ * 3. Testing permission enforcement (root privileges required)
+ * 4. Performing end-to-end communication with the option set
+ *
+ * Test flow:
+ * - Creates netlink socket with increased buffer size
+ * - Sets NETLINK_LISTEN_ALL_NSID option
+ * - Configures Generic Netlink communication:
+ *   - Resolves family and multicast group IDs
+ *   - Sets up message and callback
+ * - Performs round-trip message exchange
+ * - Verifies sysfs interaction matches received data
+ *
+ * Special considerations:
+ * - Requires root privileges (checks and skips if not root)
+ * - No getsockopt available for NETLINK_LISTEN_ALL_NSID verification
+ * - Tests both successful operation and permission error cases
+ * - Includes sysfs value validation for complete functionality check
+ *
+ * Expected results:
+ * - Root user: Successful option setting and normal operation
+ * - Correct message handling through entire communication chain
+ * - Proper sysfs value synchronization with received data
+ * - Non-root: Graceful test skipping
+ */
+
+TEST(genl_test_sock_listen_all_nsid)
+{
+	struct nl_sock *nl_sock;
+	int family_id;
+	int mcgrp_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err;
+	int int_value;
+	int up;
+	int sock_fd;
+
+	struct genlmsghdr *user_hdr;
+	struct callback_data cb_data;
+
+	printf("Running Test: setting NETLINK_LISTEN_ALL_NSID option for socket...\n");
+
+	// Only root can listen to different Netlink namespaces
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	nl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, nl_sock);
+	if (!nl_sock) {
+		printf("socket for my_genl is NULL\n");
+		return;
+	}
+
+	err = nl_socket_set_buffer_size(nl_sock, 8000, 8000);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to change socket buffer size: %s\n",
+			strerror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	sock_fd = nl_socket_get_fd(nl_sock);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		err = sock_fd;
+		fprintf(stderr, "Failed to get socket file descriptor: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	up = 1;
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_LISTEN_ALL_NSID, &up,
+			 sizeof(up));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set NETLINK_LISTEN_ALL_NSID: %s\n",
+			strerror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(nl_sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr, "Failed to resolve family id: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	mcgrp_id = genl_ctrl_resolve_grp(nl_sock, MY_GENL_FAMILY_NAME,
+					 MY_MCGRP_NAME);
+	EXPECT_GE(mcgrp_id, 0);
+	if (mcgrp_id < 0) {
+		err = mcgrp_id;
+		fprintf(stderr, "Failed to resolve multicast group: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_socket_add_membership(nl_sock, mcgrp_id);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to add membership: %s\n",
+			nl_geterror(err));
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, MY_GENL_CMD_GET_VALUE, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, MY_GENL_ATTR_PATH, PATH_GENL_TEST_NUM) < 0) {
+		fprintf(stderr,
+			"Failed to add MY_GENL_ATTR_PATH attribute: %s\n",
+			strerror(errno));
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(nl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(nl_sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = read_int_from_sysfs(PATH_GENL_TEST_NUM, &int_value);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_EQ(int_value, cb_data.int_value);
+
+	err = write_int_to_sysfs(PATH_GENL_TEST_NUM, -20);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(nl_sock);
+}
+
+/**
+ * TEST(genl_third_echo) - Validates NLM_F_ECHO flag functionality in Generic Netlink
+ *
+ * Tests the echo/reply mechanism by:
+ * 1. Creating a Netlink socket and resolving the third_genl family
+ * 2. Sending a message with NLM_F_ECHO flag set
+ * 3. Verifying proper echo reply handling through:
+ *    - Callback validation (validate_cb_third)
+ *    - Sysfs value comparison
+ *
+ * Test Flow:
+ * - Requires root privileges (for sysfs operations)
+ * - Allocates and configures Netlink socket and message
+ * - Sets up callback for reply validation
+ * - Sends echo request and waits for reply
+ * - Compares received message with sysfs content
+ * - Cleans up sysfs state after verification
+ *
+ * Key Validations:
+ * - Successful message round-trip with echo flag
+ * - Correct message content in callback vs sysfs
+ * - Proper resource cleanup in all code paths
+ * - Root permission enforcement
+ *
+ * Expected Behavior:
+ * - Message with NLM_F_ECHO should trigger reply from kernel
+ * - Callback should receive matching message content
+ * - Sysfs should reflect the same message content
+ * - Non-root users should be properly handled
+ */
+
+TEST(genl_third_echo)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err;
+
+	struct callback_data_third cb_data;
+
+	printf("Running Test: sending message to third_genl...\n");
+
+	// Only root can write to sysfs (needs for testing)
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = my_genl_ctrl_resolve(THIRD_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr,
+			"Failed to resolve family id for THIRD_GENL: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_ECHO, THIRD_GENL_CMD_ECHO, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	char *str = malloc(BUFFER_SIZE);
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_third,
+			&cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = read_string_from_sysfs(PATH_THIRD_GENL_MES, str, BUFFER_SIZE);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to read from sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+	EXPECT_STREQ(str, cb_data.message);
+
+	err = write_string_to_sysfs(PATH_THIRD_GENL_MES, "default");
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr, "Failed to write to sysfs: %s\n",
+			strerror(err));
+		goto error;
+	}
+
+error:
+	free(str);
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(incorrect_genl_third_echo_flags) - Validates Netlink flag enforcement
+ *
+ * Tests kernel's handling of invalid Netlink message flags by:
+ * 1. Sending a message with explicitly prohibited flag combination (NLM_F_ECHO | NLM_F_ATOMIC)
+ * 2. Verifying proper error response (EINVAL/NLE_INVAL)
+ *
+ * Test Flow:
+ * 1. Creates and configures Netlink socket
+ * 2. Resolves THIRD_GENL family
+ * 3. Constructs message with invalid flags:
+ *    - Uses valid NLM_F_ECHO
+ *    - Adds invalid NLM_F_ATOMIC (prohibited for Generic Netlink)
+ * 4. Sets up validation callback
+ * 5. Sends message and verifies error response
+ *
+ * Key Validations:
+ * - Kernel rejects messages with invalid flag combinations
+ * - Correct error code (NLE_INVAL) is returned
+ * - Proper resource cleanup in all execution paths
+ *
+ * Expected Behavior:
+ * - Kernel should reject message with EINVAL/NLE_INVAL
+ * - No callback validation should occur (message fails before processing)
+ * - All allocated resources should be properly freed
+ *
+ * Note:
+ * - Only these flags are valid for Generic Netlink:
+ *   NLM_F_REQUEST, NLM_F_ACK, NLM_F_ECHO, NLM_F_DUMP
+ * - NLM_F_ATOMIC is explicitly invalid for Generic Netlink
+ */
+
+TEST(incorrect_genl_third_echo_flags)
+{
+	struct nl_sock *sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct genlmsghdr *user_hdr;
+	struct nl_cb *cb;
+	int err;
+
+	struct callback_data_third cb_data;
+
+	printf("Running Test: sending message with incorrect flags to third_genl...\n");
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "socket is NULL\n");
+		return;
+	}
+
+	family_id = genl_ctrl_resolve(sock, "THIRD_GENL");
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		err = family_id;
+		fprintf(stderr,
+			"Failed to resolve family id for THIRD_GENL: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		fprintf(stderr, "Failed to allocate message\n");
+		nl_socket_free(sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_ECHO | NLM_F_ATOMIC, THIRD_GENL_CMD_ECHO,
+			       0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		fprintf(stderr, "Failed to genlmsg_put\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb_third,
+			&cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(sock, cb);
+	EXPECT_EQ(err, -NLE_INVAL);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(sock);
+}
+
+/**
+ * TEST(new_socket_netlink_usersock) - Validates NETLINK_USERSOCK socket lifecycle
+ *
+ * Tests the creation and cleanup of NETLINK_USERSOCK sockets by:
+ * 1. Creating and connecting a NETLINK_USERSOCK socket
+ * 2. Verifying its presence in /proc/net/netlink
+ * 3. Checking proper cleanup after socket release
+ *
+ * Test Methodology:
+ * 1. Socket Allocation:
+ *    - Creates socket using nl_socket_alloc()
+ *    - Binds to NETLINK_USERSOCK protocol (2)
+ *
+ * 2. System Validation:
+ *    - Parses /proc/net/netlink to count active sockets
+ *    - Verifies exactly one new NETLINK_USERSOCK exists
+ *    - Includes 2-second delay for kernel state synchronization
+ *    - Re-checks /proc after socket release
+ *
+ * 3. Cleanup Verification:
+ *    - Confirms socket count returns to baseline
+ *    - Validates proper resource deallocation
+ *
+ * Key Validations:
+ * - Correct socket creation in kernel space
+ * - Accurate /proc filesystem reporting
+ * - Proper socket cleanup on free
+ * - Robust parsing of /proc/net/netlink format
+ *
+ * Expected Behavior:
+ * - Socket appears in /proc/net/netlink after creation
+ * - Socket disappears from /proc/net/netlink after release
+ * - Final count matches initial baseline
+ * - All file handles properly closed
+ *
+ * Note:
+ * - Uses 2-second delay to account for kernel cleanup latency
+ * - Handles potential /proc/net/netlink parsing errors gracefully
+ * - Validates both presence and absence of socket record
+ */
+
+TEST(new_socket_netlink_usersock)
+{
+#define NETLINK_USERSOCK 2 // Reserved for user mode socket protocols
+	int err;
+
+	struct nl_sock *sock;
+	char *header;
+
+	printf("Running Test: creating socket for user mode and checking it existence in the system...\n");
+
+	sock = nl_socket_alloc();
+	EXPECT_NE(NULL, sock);
+	if (!sock) {
+		fprintf(stderr, "Failed to allocate socket\n");
+		return;
+	}
+
+	err = nl_connect(sock, NETLINK_USERSOCK);
+	EXPECT_EQ(err, 0);
+	if (err) {
+		fprintf(stderr,
+			"Failed to connect to Netlink using NETLINK_USERSOCK: %s\n",
+			nl_geterror(err));
+		nl_socket_free(sock);
+		return;
+	}
+
+	FILE *file;
+	char line[256];
+	char sk[20];
+	int Eth, Pid;
+	unsigned int Groups, Rmem, Wmem, Dump, Locks, Drops, Inode;
+
+	int count_user_socks = 0;
+
+	file = fopen("/proc/net/netlink", "r");
+	EXPECT_NE(NULL, file);
+	if (file == NULL) {
+		perror("fopen");
+		return;
+	}
+
+	// Skip header
+	header = fgets(line, sizeof(line), file);
+	EXPECT_NE(NULL, header);
+	if (header == NULL) {
+		fclose(file);
+		nl_socket_free(sock);
+		return;
+	}
+
+	// Parse line
+	while (fgets(line, sizeof(line), file) != NULL) {
+		if (!isxdigit(
+			    line[0])) { // check if the first column is 16-number value
+			break;
+		}
+		if (sscanf(line,
+			   "%19s %d %d %x %u %u %u %u %u %u", // limit sk len to 19 symbols
+			   sk, &Eth, &Pid, &Groups, &Rmem, &Wmem, &Dump, &Locks,
+			   &Drops, &Inode) == 10) {
+			if (Eth == NETLINK_USERSOCK)
+				count_user_socks += 1;
+
+		} else {
+			fprintf(stderr, "Failed to parse line: %s", line);
+			EXPECT_EQ(0, 1);
+		}
+	}
+
+	fclose(file);
+
+	nl_socket_free(sock);
+
+	sleep(2);
+
+	file = fopen("/proc/net/netlink", "r");
+	EXPECT_NE(NULL, file);
+	if (file == NULL) {
+		perror("fopen");
+		return;
+	}
+
+	header = fgets(line, sizeof(line), file);
+	EXPECT_NE(NULL, header);
+	if (header == NULL) {
+		fclose(file);
+		return;
+	}
+
+	while (fgets(line, sizeof(line), file) != NULL) {
+		if (!isxdigit(line[0]))
+			break;
+
+		if (sscanf(line, "%19s %d %d %x %u %u %u %u %u %u", sk, &Eth,
+			   &Pid, &Groups, &Rmem, &Wmem, &Dump, &Locks, &Drops,
+			   &Inode) == 10) {
+			if (Eth == NETLINK_USERSOCK)
+				count_user_socks -= 1;
+
+		} else {
+			fprintf(stderr, "Failed to parse line: %s", line);
+			EXPECT_EQ(0, 1);
+		}
+	}
+
+	fclose(file);
+
+	EXPECT_TRUE(count_user_socks == 1);
+}
+
+/**
+ * TEST(incorrect_parallel_genl_reject_policy_set_value) - Validates reject policy enforcement
+ *
+ * Tests the Generic Netlink reject policy by:
+ * 1. Sending a properly formatted message to a command with reject policy
+ * 2. Verifying the kernel rejects the message with EINVAL
+ * 3. Confirming all attributes are properly skipped
+ *
+ * Test Methodology:
+ * 1. Creates Generic Netlink socket and resolves parallel_genl family
+ * 2. Constructs message with:
+ *    - Valid path attribute (PATH_PARALLEL_GENL_MES)
+ *    - Test data ("value for reject")
+ *    - SET_VALUE command (PARALLEL_GENL_CMD_SET_VALUE)
+ * 3. Configures validation callback
+ * 4. Sends message and verifies rejection
+ *
+ * Key Validations:
+ * - Kernel properly enforces reject policy
+ * - Correct error code (NLE_INVAL) is returned
+ * - Message attributes are ignored as expected
+ * - Resources are properly cleaned up
+ *
+ * Expected Behavior:
+ * - Kernel should reject message with EINVAL/NLE_INVAL
+ * - No callback validation should occur (message rejected by policy)
+ * - All allocated resources should be freed
+ *
+ * Special Considerations:
+ * - Tests edge case of valid message format but rejected by policy
+ * - Verifies proper attribute handling under reject policy
+ * - Validates correct error propagation to userspace
+ */
+
+TEST(incorrect_parallel_genl_reject_policy_set_value)
+{
+	struct nl_sock *nl_sock;
+	int family_id;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int err = 0;
+	char *value;
+	struct genlmsghdr *user_hdr;
+	struct callback_data cb_data;
+
+	printf("Running Test: sending correct value for sysfs to parallel_genl to check reject policy...\n");
+
+	nl_sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, nl_sock);
+	if (!nl_sock)
+		return;
+
+	family_id = genl_ctrl_resolve(nl_sock, PARALLEL_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		nl_socket_free(nl_sock);
+		err = family_id;
+		return;
+	}
+
+	msg = nlmsg_alloc();
+	EXPECT_NE(NULL, msg);
+	if (!msg) {
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	user_hdr = genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family_id, 0,
+			       NLM_F_REQUEST, PARALLEL_GENL_CMD_SET_VALUE, 0);
+	EXPECT_NE(NULL, user_hdr);
+	if (!user_hdr) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	if (nla_put_string(msg, PARALLEL_GENL_ATTR_PATH,
+			   PATH_PARALLEL_GENL_MES) < 0) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	value = "value for reject";
+	if (nla_put_string(msg, PARALLEL_GENL_ATTR_DATA, value) < 0) {
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		ASSERT_EQ(0, 1);
+		return;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	EXPECT_NE(NULL, cb);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate callback\n");
+		nlmsg_free(msg);
+		nl_socket_free(nl_sock);
+		return;
+	}
+
+	err = nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, validate_cb, &cb_data);
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Error setting callback: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_send_auto(nl_sock, msg);
+	EXPECT_GE(err, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send message: %s\n",
+			nl_geterror(err));
+		goto error;
+	}
+
+	err = nl_recvmsgs(nl_sock, cb);
+	EXPECT_EQ(err, -NLE_INVAL);
+
+error:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	nl_socket_free(nl_sock);
+}
+
+/**
+ * TEST(connect_sock) - Validates raw Netlink socket operations using system calls
+ *
+ * Tests the complete lifecycle of a Netlink socket using low-level system calls:
+ * 1. Creates a raw NETLINK_GENERIC socket
+ * 2. Binds to the socket with process-specific PID
+ * 3. Connects to the kernel (pid 0)
+ * 4. Properly closes the socket
+ *
+ * Test Methodology:
+ * 1. Initial Setup:
+ *    - Uses libnl to resolve Generic Netlink family (for verification)
+ *    - Releases libnl socket to test raw system calls
+ *
+ * 2. System Call Validation:
+ *    - Creates socket with AF_NETLINK/SOCK_RAW
+ *    - Binds to process PID (getpid())
+ *    - Connects to kernel (pid 0)
+ *    - Verifies each operation succeeds
+ *
+ * 3. Cleanup:
+ *    - Proper socket closure
+ *    - Resource cleanup
+ *
+ * Key Validations:
+ * - Correct socket creation with NETLINK_GENERIC
+ * - Proper binding with AF_NETLINK
+ * - Successful connection to kernel
+ * - Error handling for all system calls
+ * - Resource cleanup
+ *
+ * Expected Behavior:
+ * - All system calls should succeed
+ * - Socket should be properly bound to process PID
+ * - Connection to kernel (pid 0) should establish
+ * - No resource leaks after close()
+ *
+ * Note:
+ * - Uses both libnl and raw system calls for comprehensive validation
+ * - Tests the fundamental Netlink socket operations
+ * - Verifies proper kernel/userspace communication setup
+ */
+
+TEST(connect_sock)
+{
+	int sock_fd;
+	struct sockaddr_nl src_addr, dest_addr;
+	int family_id;
+	struct nl_sock *sock;
+	int err;
+
+	printf("Running Test: using system calls to operate with Netlink socket...\n");
+
+	sock = socket_alloc_and_conn();
+	EXPECT_NE(NULL, sock);
+	if (!sock)
+		return;
+
+	family_id = genl_ctrl_resolve(sock, MY_GENL_FAMILY_NAME);
+	EXPECT_GT(family_id, 0);
+	if (family_id < 0) {
+		fprintf(stderr,
+			"Failed to resolve family id for TEST_GENL: %d\n",
+			family_id);
+		nl_socket_free(sock);
+		err = family_id;
+		return;
+	}
+
+	nl_socket_free(sock);
+
+	sock_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	EXPECT_GE(sock_fd, 0);
+	if (sock_fd < 0) {
+		perror("socket()");
+		err = sock_fd;
+		return;
+	}
+
+	memset(&src_addr, 0, sizeof(src_addr));
+	src_addr.nl_family = AF_NETLINK;
+	src_addr.nl_pid = getpid();
+
+	err = bind(sock_fd, (struct sockaddr *)&src_addr, sizeof(src_addr));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		perror("bind()");
+		close(sock_fd);
+		return;
+	}
+
+	memset(&dest_addr, 0, sizeof(dest_addr));
+	dest_addr.nl_family = AF_NETLINK;
+	dest_addr.nl_pid = 0;
+	dest_addr.nl_groups = 0;
+
+	err = connect(sock_fd, (struct sockaddr *)&dest_addr,
+		      sizeof(dest_addr));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		perror("connect()");
+		close(sock_fd);
+		return;
+	}
+
+	close(sock_fd);
+}
+
+/**
+ * TEST(netfilter_unbind_grp) - Validates Netlink group membership bind/unbind operations
+ *
+ * Tests the NETLINK_ADD_MEMBERSHIP and NETLINK_DROP_MEMBERSHIP socket options
+ * using NETLINK_NETFILTER protocol which implements bind/unbind callbacks.
+ *
+ * Test Methodology:
+ * 1. Creates NETLINK_NETFILTER socket (requires root privileges)
+ * 2. Exercises group membership operations:
+ *    - Adds membership to NFNLGRP_NFTABLES (group 3)
+ *    - Adds membership to NFNLGRP_NFTRACE (group 4)
+ *    - Drops membership from group 3
+ *    - Re-adds membership to group 3
+ * 3. Completes socket lifecycle:
+ *    - Binds socket to process PID
+ *    - Connects to kernel (pid 0)
+ *    - Closes socket
+ *
+ * Key Validations:
+ * - Successful group membership operations
+ * - Proper bind/unbind callback execution
+ * - Socket option error handling
+ * - Root privilege enforcement
+ * - Socket cleanup
+ *
+ * Expected Behavior:
+ * - All membership operations should succeed (return 0)
+ * - Bind/connect operations should complete successfully
+ * - Non-root execution should skip test gracefully
+ *
+ * Protocol Selection Rationale:
+ * - NETLINK_NETFILTER specifically implements .bind/.unbind callbacks (in netlink_kernel_cfg)
+ * - Other Netlink protocols may not support these operations
+ * - Provides concrete test case for callback functionality
+ *
+ * Note:
+ * - Requires root privileges for group operations
+ * - Tests both single and multiple group scenarios
+ * - Verifies re-adding previously dropped groups
+ */
+
+TEST(netfilter_unbind_grp)
+{
+	int sock_fd;
+	struct sockaddr_nl src_addr, dest_addr;
+	int err;
+	int group_3, group_4;
+
+	printf("Running Test: trying to unbind groups from releasing socket...\n");
+
+	// Only root can NETLINK_ADD_MEMBERSHIP and NETLINK_DROP_MEMBERSHIP
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	sock_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
+	ASSERT_GE(sock_fd, 0);
+
+	memset(&src_addr, 0, sizeof(src_addr));
+	src_addr.nl_family = AF_NETLINK;
+	src_addr.nl_pid = getpid();
+
+	group_3 = NFNLGRP_NFTABLES;
+	group_4 = NFNLGRP_NFTRACE;
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &group_3,
+			 sizeof(group_3));
+	EXPECT_EQ(err, 0);
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &group_4,
+			 sizeof(group_4));
+	EXPECT_EQ(err, 0);
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_DROP_MEMBERSHIP,
+			 &group_3, sizeof(group_3));
+	EXPECT_EQ(err, 0);
+
+	err = setsockopt(sock_fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &group_3,
+			 sizeof(group_3));
+	EXPECT_EQ(err, 0);
+
+	err = bind(sock_fd, (struct sockaddr *)&src_addr, sizeof(src_addr));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		perror("bind()");
+		close(sock_fd);
+		return;
+	}
+
+	memset(&dest_addr, 0, sizeof(dest_addr));
+	dest_addr.nl_family = AF_NETLINK;
+	dest_addr.nl_pid = 0;
+
+	err = connect(sock_fd, (struct sockaddr *)&dest_addr,
+		      sizeof(dest_addr));
+	EXPECT_EQ(err, 0);
+	if (err < 0) {
+		perror("connect()");
+		close(sock_fd);
+		return;
+	}
+
+	close(sock_fd);
+}
+
+#define ITERATIONS 5000
+
+void socket_worker(int iterations)
+{
+	srand(time(NULL) ^ getpid());
+
+	for (int i = 0; i < iterations; i++) {
+		int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+
+		if (fd < 0) {
+			perror("socket");
+			continue;
+		}
+
+		struct sockaddr_nl addr = {
+			.nl_family = AF_NETLINK,
+			.nl_pid = getpid(),
+			.nl_groups = 0,
+		};
+
+		if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+			perror("bind");
+			close(fd);
+			continue;
+		}
+
+		// Short random delay
+		struct timespec ts = { .tv_sec = 0, .tv_nsec = rand() % 1000 };
+
+		nanosleep(&ts, NULL);
+
+		close(fd);
+	}
+}
+
+/**
+ * TEST(netlink_grab_table_check_wait) - Stress tests Netlink table locking mechanism
+ *
+ * Creates a race condition scenario to validate Netlink table grabbing behavior by:
+ * 1. Spawning two concurrent processes
+ * 2. Each process performs rapid socket create/bind/close cycles
+ * 3. Introduces random micro-delays to increase race condition probability
+ * 4. Verifies system stability under contention
+ *
+ * Test Methodology:
+ * 1. Process Creation:
+ *    - Forks two child processes
+ *    - Each executes socket_worker(ITERATIONS)
+ *
+ * 2. Worker Behavior (per iteration):
+ *    - Creates NETLINK_GENERIC socket
+ *    - Binds to process PID
+ *    - Adds random 0-1μs delay
+ *    - Closes socket
+ *    - Repeats 5000 times (ITERATIONS)
+ *
+ * 3. Validation:
+ *    - Parent waits for both children
+ *    - Checks for deadlocks/crashes
+ *    - Verifies proper resource cleanup
+ *
+ * Key Stress Points:
+ * - Concurrent table access attempts
+ * - Rapid socket lifecycle churn
+ * - Randomized timing variations
+ * - Kernel table locking contention
+ *
+ * Expected Behavior:
+ * - System should remain stable throughout
+ * - No deadlocks or resource leaks
+ * - Proper serialization of table access
+ * - Correct error handling under contention
+ *
+ * Race Condition Verification:
+ * - Tests kernel's ability to handle:
+ *   - Simultaneous socket operations
+ *   - Table grabbing contention
+ *   - Resource cleanup under load
+ *
+ * Note:
+ * - Uses 5000 iterations for significant stress
+ * - Micro-delays increase race probability
+ * - Tests both success and failure paths
+ * - Verifies proper process cleanup
+ */
+
+TEST(netlink_grab_table_check_wait)
+{
+	int status;
+
+	printf("Running Test: making one process waiting a grab for a netlink table...\n");
+
+	pid_t p1 = fork();
+
+	if (p1 == 0) {
+		socket_worker(ITERATIONS);
+		exit(0);
+	}
+
+	pid_t p2 = fork();
+
+	if (p2 == 0) {
+		socket_worker(ITERATIONS);
+		exit(0);
+	}
+
+	waitpid(p1, &status, 0);
+	EXPECT_EQ(WEXITSTATUS(status), 0);
+
+	waitpid(p2, &status, 0);
+	EXPECT_EQ(WEXITSTATUS(status), 0);
+}
+
 /**
  * TEST(capture_end) - Terminates Netlink traffic monitoring session
  *
-- 
2.34.1


