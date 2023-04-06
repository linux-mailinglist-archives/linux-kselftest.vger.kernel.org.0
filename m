Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB0F6DA4F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjDFVy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDFVy4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087379EF3;
        Thu,  6 Apr 2023 14:54:54 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818092;
        bh=gdtMqD9cVgCQr6akdRRL11+XYs6brwtyfOnOQ2LQk4A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GJSX6AXBprEX2dSMIQSilbFhVVjV2o274TjhG8igjp7UpPVZySChxRUu5c621F0aQ
         47xUd4MdnZ6mkh+CZEc0ODDC2t2aBG06HyO4KJkj33j+mt/A18r+cMcwy/AtsCVqxk
         mtCN7ZRgbeBJCAaIRgduLc0KmRj2oRuSAYnjmkm0=
Date:   Thu, 06 Apr 2023 21:54:48 +0000
Subject: [PATCH v2 02/11] tools/nolibc: use __inline__ syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-2-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=3469;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gdtMqD9cVgCQr6akdRRL11+XYs6brwtyfOnOQ2LQk4A=;
 b=EdYL72397iLYKjJXbVFusjZuMDs5WazWBO+FX53GIWWTa2/u6/0k/DKwgr0QK48GizOuIFjSc
 2QO/U8hWSajAbRI0jryiCQjEJwIQxzWepWr3uS8jK2VPvKfmGHiIEse
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building in strict C89 mode the "inline" keyword is unknown.
While "__inline__" is non-standard it is used by the kernel headers
themselves.
So the used compilers would have to support it or the users shim it with
a #define.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdlib.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 894c955d027e..902162f80337 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -102,7 +102,7 @@ char *_getenv(const char *name, char **environ)
 	return NULL;
 }
 
-static inline __attribute__((unused,always_inline))
+static __inline__ __attribute__((unused,always_inline))
 char *getenv(const char *name)
 {
 	extern char **environ;
@@ -231,7 +231,7 @@ int utoh_r(unsigned long in, char *buffer)
 /* converts unsigned long <in> to an hex string using the static itoa_buffer
  * and returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *utoh(unsigned long in)
 {
 	utoh_r(in, itoa_buffer);
@@ -293,7 +293,7 @@ int itoa_r(long in, char *buffer)
 /* for historical compatibility, same as above but returns the pointer to the
  * buffer.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *ltoa_r(long in, char *buffer)
 {
 	itoa_r(in, buffer);
@@ -303,7 +303,7 @@ char *ltoa_r(long in, char *buffer)
 /* converts long integer <in> to a string using the static itoa_buffer and
  * returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *itoa(long in)
 {
 	itoa_r(in, itoa_buffer);
@@ -313,7 +313,7 @@ char *itoa(long in)
 /* converts long integer <in> to a string using the static itoa_buffer and
  * returns the pointer to that string. Same as above, for compatibility.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *ltoa(long in)
 {
 	itoa_r(in, itoa_buffer);
@@ -323,7 +323,7 @@ char *ltoa(long in)
 /* converts unsigned long integer <in> to a string using the static itoa_buffer
  * and returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *utoa(unsigned long in)
 {
 	utoa_r(in, itoa_buffer);
@@ -367,7 +367,7 @@ int u64toh_r(uint64_t in, char *buffer)
 /* converts uint64_t <in> to an hex string using the static itoa_buffer and
  * returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *u64toh(uint64_t in)
 {
 	u64toh_r(in, itoa_buffer);
@@ -429,7 +429,7 @@ int i64toa_r(int64_t in, char *buffer)
 /* converts int64_t <in> to a string using the static itoa_buffer and returns
  * the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *i64toa(int64_t in)
 {
 	i64toa_r(in, itoa_buffer);
@@ -439,7 +439,7 @@ char *i64toa(int64_t in)
 /* converts uint64_t <in> to a string using the static itoa_buffer and returns
  * the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *u64toa(uint64_t in)
 {
 	u64toa_r(in, itoa_buffer);

-- 
2.40.0

