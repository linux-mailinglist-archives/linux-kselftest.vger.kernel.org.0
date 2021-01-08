Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756B2EF7C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jan 2021 19:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbhAHS6j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jan 2021 13:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbhAHS6i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jan 2021 13:58:38 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1730C061381
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jan 2021 10:57:58 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id n9so11305860ili.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jan 2021 10:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=FNhZRCl91qEvqxJsjhVSSj1Ts2b8rnqLDD7r1EyJAFA=;
        b=ItQp6/R2EJzmweVMsrMWWEOuirEkz1K9xP02oHPxakb1Fc3mrAQgSw+9bMuEoZPN7Z
         09llnbVDZer4mEqnXEIsArGWvWG0PjPeSvM2MVo4f2tvR+Zb3GH/NI+3MAhmcle5BqNO
         cbyDHKWtQqzrB7r0XUftZrcUIwgsIeXLF/Qw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=FNhZRCl91qEvqxJsjhVSSj1Ts2b8rnqLDD7r1EyJAFA=;
        b=sNWGS7PDv3kRmA8v2EWGN13JC5V+3jM4pssbFpKk3vjP1in9XaDZ7y46W6G9s4PnyC
         2Zlu57rS9gMmu0ffYRWcKJUGJw/jF699uY/YKF/qWdN3zIIZELw9Tk7pOEFvlE7mRCjJ
         ynG97zNQfyLaaXH/irkTO1fSiHXAEuIjTCxZub3KnjtxJO+uif35daCtZMsfvVEoWGqn
         dyvPETZDvlHmmBkzm+cdbRQ1DTIAssfxWzoflVJbotCcKV2SBTfRg2mBBMNk47a5pwEl
         H8Ag2EEecTqWpUWGo0Y6iY4YOlnTJ/Jh8hYANR9Ymq2ss/50AoYMYoHZoQEQmplgYmoE
         jYig==
X-Gm-Message-State: AOAM530DfaUs0JCAM0kK7i5uafgq97Gt4flC5KFm1Z1qwwgeW2WyY2e4
        NQDvmlPDDOuV7wwNFLcxgFOTA2f1+zDXcw==
X-Google-Smtp-Source: ABdhPJxjdKnqcdmx9ql3JR8E49405vETqSaBMPiKBLaofz68h/A6BMdzHAGrgs+WU+e0/vwVqL2hUA==
X-Received: by 2002:a92:444e:: with SMTP id a14mr5147436ilm.129.1610132277912;
        Fri, 08 Jan 2021 10:57:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y5sm7639901ilh.24.2021.01.08.10.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 10:57:57 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.11-rc3
Message-ID: <7410da21-2442-1bb9-1dc9-0ec79483e9d3@linuxfoundation.org>
Date:   Fri, 8 Jan 2021 11:57:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A66FBD906777F4ADF664407D"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------A66FBD906777F4ADF664407D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5.11-rc3.

This kunit update for Linux 5.11-rc3 consists one fix to force the use
of the 'tty' console for UML. Given that kunit tool requires the console
output, explicitly stating the dependency makes sense than relying on
it being the default.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

   Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.11-rc3

for you to fetch changes up to 65a4e5299739abe0888cda0938d21f8ea3b5c606:

   kunit: tool: Force the use of the 'tty' console for UML (2021-01-04 
09:18:38 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.11-rc3

This kunit update for Linux 5.11-rc3 consists one fix to force the use
of the 'tty' console for UML. Given that kunit tool requires the console
output, explicitly stating the dependency makes sense than relying on
it being the default.

----------------------------------------------------------------
David Gow (1):
       kunit: tool: Force the use of the 'tty' console for UML

  tools/testing/kunit/kunit_kernel.py | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
----------------------------------------------------------------

--------------A66FBD906777F4ADF664407D
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.11-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.11-rc3.diff"

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 57c1724b7e5d..698358c9c0d6 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -198,7 +198,7 @@ class LinuxSourceTree(object):
 		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], build_dir='', timeout=None):
-		args.extend(['mem=1G'])
+		args.extend(['mem=1G', 'console=tty'])
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
 		subprocess.call(['stty', 'sane'])

--------------A66FBD906777F4ADF664407D--
