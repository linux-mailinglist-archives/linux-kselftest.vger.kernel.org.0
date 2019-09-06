Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43902ABC77
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391173AbfIFP2S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 11:28:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbfIFP2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 11:28:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McpS0-1if2jw10Ms-00ZtUu; Fri, 06 Sep 2019 17:28:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: add PRINTK dependency
Date:   Fri,  6 Sep 2019 17:27:45 +0200
Message-Id: <20190906152800.1662489-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xQht81px/ceYx++wN+B2QvBkFd39U6O35ZakKPBR4duPVEzMpZ6
 aEvP0fGtplDdzkiG5ZJ/xJxJyreFTU0C341Rp/SN2n0HPHSrTQP/6UZ0TW+Mf8UGOHL4mLz
 GTOPiILBrpAAAdleY1XIxLrQdPcgjFpzktrxx+SGY3A1FwPrthVxPXhBPSo8iies5eiSYZa
 U2PEq/uSfNR5FxEDzv8uQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MA9m20dznII=:XUqyWaYvYb9f8p8w20bBZw
 uUH4FdWPjuZV89mmTgGVg99mY1ukZgPeRT+GRh3d6lFToBjKbfaoh+PmKdZTIDiIUCcdkvkf3
 eqLpOXSKy+7Cs9NfX4KBMIYOpupDHVKoqJ+yfzHoF9OduOtbREqZKPxILC/BCQpD4YKGLbIIw
 DNCP3cfCvCMnIwAeZNcG7dipqZZ2wlS0xakiks6J8mfnEQhZSr26fwdQxbM2688t9tRNtEqjA
 yTTnx1iKlvMlh49KpbLGGI6IpI7c2QD6R1VGJBZEmRr4BdyaqiIqlYDW4V8weFPxQoWdhyLzq
 am01dgujshTbqbIN59MHpnrhDSnL3QXC+VyoZHLFQaQVENJEzAcug5gLe2s2jMk2SBjuSZvGA
 jqCjOo8Qs7Eq18oR0oi2QwHuqZrc5r0UkV5mDtKnSOzWkkYDb0UFRp5s85qkmB0iAwD95LWyA
 W9A53ip3HNK/i2ObdeiMlOBrX0FPLxIHj6AHYxQCHgJy460f40xfJKtz6QkG/UhanqwC2dyLq
 wsdGz3Gi3NQI3FNzDKALgpvjFDUuQm6RfVz5XMXO8jaNuoCljo3KFv0o8GCME0evUTxCMF90h
 mLxIC2PYdRLaximU2IvVHo3wOXZrjR2KgRYvIkqc8hrHOvyQu7AsqlMvyZNsmOKsiraqzeOlb
 jJRTh7BwokLj9xW7sYT+gtI/I5uUYOtUvdFUOwPejtkt1gAYXsfd+Vw+70D/l3GpxqEYL6KJ4
 HpZQX2IqcjmfkvRndSrXkul9Gv55FMvdXeyBzHZbQfSoyOqr6dy07YIy2E8VNv1UlGy0g/PdA
 38ErFLNR+/f4+zn+KK9Adr6DLMlF/vyT82/VH6lVuYBenCk008=
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The vprintk_emit() function is not available when CONFIG_PRINTK
is disabled:

kunit/test.c:22:9: error: implicit declaration of function 'vprintk_emit' [-Werror,-Wimplicit-function-declaration]

I suppose without printk(), there is not much use in kunit
either, so add a Kconfig depenedency here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kunit/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kunit/Kconfig b/kunit/Kconfig
index 8541ef95b65a..e80d8af00454 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -6,6 +6,7 @@ menu "KUnit support"
 
 config KUNIT
 	bool "Enable support for unit tests (KUnit)"
+	depends on PRINTK
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
-- 
2.20.0

