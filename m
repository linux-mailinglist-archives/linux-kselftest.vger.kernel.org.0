Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF14D6652
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349945AbiCKQ3s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiCKQ14 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:27:56 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734A1D529D;
        Fri, 11 Mar 2022 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015977;
  x=1678551977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PfFSPTWiAxOHXxpoOxuYzI006DPifNqh9ag3eFnVu00=;
  b=KXIQvuD3/N8kcHSEC8M0D6nMHJxscprLbgCfbGKbeNhnAdKgF8RJMKEf
   n7AQZ5CGO27AJw8STmIIyd7Q7PvSXONwH8Nz6nusnIcxVlCukTa9GYo3V
   jC121aaNeBYKiLYN99Rxg5sveXGmlZiwIr7zLML01qcctjPVg7xQ1zvd5
   ZghKXVYbhJ6hAlsmZ+oQBXqKz8l4g5AJdxoo9eBs4crenD4NSRRoo4QBo
   gqU8AHneR8R7WJ2feIfJaZFLTefmUr15u4GW8bRQ+4So01Nj7zo3tRKX2
   wxhzryEjCzyShUFCNZ5WJFDbV5Wv93MaVwjhYF8G1pqw98cuxi58ZGWQF
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <devicetree@vger.kernel.org>, <linux-um@lists.infradead.org>,
        <shuah@kernel.org>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [RFC v1 05/10] roadtest: add build files
Date:   Fri, 11 Mar 2022 17:24:40 +0100
Message-ID: <20220311162445.346685-6-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a Makefile and other miscellaneous build-related files for the
roadtest framework.

To make it easier to run the tests on systems which do not have the
required libraries or Python version, a Dockerfile is included and the
Makefile has built-in support for running the tests in a Docker
container.

Targets for code formatting and static checking of the Python code are
included.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 tools/testing/roadtest/.gitignore       |  2 +
 tools/testing/roadtest/Dockerfile       | 25 ++++++++
 tools/testing/roadtest/Makefile         | 84 +++++++++++++++++++++++++
 tools/testing/roadtest/pyproject.toml   | 10 +++
 tools/testing/roadtest/requirements.txt |  4 ++
 tools/testing/roadtest/src/.gitignore   |  1 +
 6 files changed, 126 insertions(+)
 create mode 100644 tools/testing/roadtest/.gitignore
 create mode 100644 tools/testing/roadtest/Dockerfile
 create mode 100644 tools/testing/roadtest/Makefile
 create mode 100644 tools/testing/roadtest/pyproject.toml
 create mode 100644 tools/testing/roadtest/requirements.txt
 create mode 100644 tools/testing/roadtest/src/.gitignore

diff --git a/tools/testing/roadtest/.gitignore b/tools/testing/roadtest/.gitignore
new file mode 100644
index 000000000000..0cbd00343694
--- /dev/null
+++ b/tools/testing/roadtest/.gitignore
@@ -0,0 +1,2 @@
+__pycache__
+.py[cod]
diff --git a/tools/testing/roadtest/Dockerfile b/tools/testing/roadtest/Dockerfile
new file mode 100644
index 000000000000..f2982179c327
--- /dev/null
+++ b/tools/testing/roadtest/Dockerfile
@@ -0,0 +1,25 @@
+FROM debian:bullseye
+
+# Kernel build
+RUN apt-get update && apt-get -y install \
+    bc \
+    build-essential \
+    flex \
+    bison \
+    rsync \
+    kmod
+
+# Running roadtests
+RUN apt-get update && apt-get -y install \
+     python3.9 \
+     libpython3.9-dev \
+     python3 \
+     device-tree-compiler
+
+# Development and debugging
+RUN apt-get update && apt-get -y install \
+     uml-utilities \
+     telnetd \
+     python3-pip
+COPY requirements.txt /tmp/
+RUN pip install --requirement /tmp/requirements.txt
diff --git a/tools/testing/roadtest/Makefile b/tools/testing/roadtest/Makefile
new file mode 100644
index 000000000000..525b26581142
--- /dev/null
+++ b/tools/testing/roadtest/Makefile
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+.PHONY: all build-kernel test clean check fmt docker-run
+
+all:
+
+KSOURCE := ${PWD}
+ROADTEST_DIR = ${CURDIR}
+ROADTEST_BUILD_DIR := ${KSOURCE}/.roadtest
+KHEADERS := ${ROADTEST_BUILD_DIR}/usr
+KMODULES := ${ROADTEST_BUILD_DIR}/modules
+
+ifeq (${KSOURCE},${ROADTEST_DIR})
+# Make make from the standard roadtest directory work without having to set
+# additional variables.
+KSOURCE=$(ROADTEST_DIR:/tools/testing/roadtest=)
+endif
+
+CFLAGS += -g -D_GNU_SOURCE=1 -Wall -Werror -std=gnu99 \
+			-I${KSOURCE}/tools/include/ \
+			-I${KHEADERS}/include/ \
+			-I${ROADTEST_DIR}/src/libvhost-user/ \
+			$(shell python3-config --embed --includes) -O2
+
+${ROADTEST_BUILD_DIR}/roadtest-backend: ${ROADTEST_BUILD_DIR}/backend.o ${ROADTEST_BUILD_DIR}/libvhost-user.o
+	$(CC) -o $@ $^ $(shell python3-config --embed --libs)
+	# For the benefit of clangd
+	echo ${CFLAGS} | tr " " "\n" > ${ROADTEST_DIR}/src/compile_flags.txt
+
+${ROADTEST_BUILD_DIR}/backend.o: src/backend.c
+	$(CC) -c -o $@ $(CFLAGS) $<
+
+${ROADTEST_BUILD_DIR}/libvhost-user.o: src/libvhost-user/libvhost-user.c
+	$(CC) -c -o $@ $(CFLAGS) $<
+
+clean:
+	rm -rf ${ROADTEST_BUILD_DIR} .docker_built
+
+ifeq ($(DOCKER),1)
+.docker_built: Dockerfile requirements.txt
+	docker build --network=host -t roadtest ${ROADTEST_DIR}
+	touch $@
+
+# --network=host allows UML's con=port:... to work seamlessly
+docker-run: .docker_built
+	mkdir -p ${ROADTEST_BUILD_DIR}/umltmp
+	docker run --network=host ${DOCKEROPTS} --user $(shell id -u ${USER}):$(shell id -g ${USER}) --interactive --tty --rm -v ${KSOURCE}:${KSOURCE} -w ${KSOURCE} --env TMPDIR=${ROADTEST_BUILD_DIR}/umltmp roadtest sh -c '${MAKE} -C ${ROADTEST_DIR} -${MAKEFLAGS} ${MAKECMDGOALS} DOCKER=0'
+
+all test build-kernel check fmt: docker-run
+	@:
+else
+all: test
+
+ifneq ($(KBUILD),0)
+# Calling make on the kernel is slow even if there is nothing to be rebuilt.
+# Allow the user to avoid it with KBUILD=0
+${ROADTEST_BUILD_DIR}/backend.o: build-kernel
+${ROADTEST_BUILD_DIR}/libvhost-user.o: build-kernel
+test: build-kernel
+endif
+
+build-kernel:
+	mkdir -p ${ROADTEST_BUILD_DIR}
+	find ${ROADTEST_DIR}/roadtest/tests/ -type f -name config | xargs cat > ${ROADTEST_BUILD_DIR}/.config
+	${MAKE} -C ${KSOURCE} ARCH=um O=${ROADTEST_BUILD_DIR} olddefconfig
+	${MAKE} -C ${KSOURCE} ARCH=um O=${ROADTEST_BUILD_DIR}
+	${MAKE} -C ${KSOURCE} ARCH=um O=${ROADTEST_BUILD_DIR} INSTALL_HDR_PATH=${KHEADERS} headers_install
+	${MAKE} -C ${KSOURCE} ARCH=um O=${ROADTEST_BUILD_DIR} INSTALL_MOD_PATH=${KMODULES} modules_install
+
+test: ${ROADTEST_BUILD_DIR}/roadtest-backend
+	python3 -m roadtest.cmd.main --ksrc-dir ${KSOURCE} --build-dir ${ROADTEST_BUILD_DIR} --work-dir ${ROADTEST_BUILD_DIR}/roadtest-work/ ${OPTS}
+
+check:
+	mypy --no-error-summary roadtest
+	pyflakes roadtest
+	black --check roadtest
+	isort --profile black --check roadtest
+
+fmt:
+	black roadtest
+	isort --profile black roadtest
+
+endif
diff --git a/tools/testing/roadtest/pyproject.toml b/tools/testing/roadtest/pyproject.toml
new file mode 100644
index 000000000000..6b8b05eb3cad
--- /dev/null
+++ b/tools/testing/roadtest/pyproject.toml
@@ -0,0 +1,10 @@
+[tool.isort]
+profile = "black"
+
+[tool.mypy]
+disallow_untyped_defs = true
+check_untyped_defs = true
+no_implicit_optional = true
+warn_return_any = true
+warn_unused_ignores = true
+show_error_codes = true
diff --git a/tools/testing/roadtest/requirements.txt b/tools/testing/roadtest/requirements.txt
new file mode 100644
index 000000000000..e1ac403d826e
--- /dev/null
+++ b/tools/testing/roadtest/requirements.txt
@@ -0,0 +1,4 @@
+black==22.1.0
+isort==5.10.1
+mypy==0.931
+pyflakes==2.4.0
diff --git a/tools/testing/roadtest/src/.gitignore b/tools/testing/roadtest/src/.gitignore
new file mode 100644
index 000000000000..895dab3fe4be
--- /dev/null
+++ b/tools/testing/roadtest/src/.gitignore
@@ -0,0 +1 @@
+compile_flags.txt
-- 
2.34.1

