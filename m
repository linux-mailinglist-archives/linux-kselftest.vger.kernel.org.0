Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAD5EC9EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiI0Qs7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiI0Qsd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 12:48:33 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B29578A2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 09:47:55 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4McQXp4wNXzMqhJk;
        Tue, 27 Sep 2022 18:47:54 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4McQXp18VRzxR;
        Tue, 27 Sep 2022 18:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664297274;
        bh=rgWmPEsXTNpU/14N1h/JP8Zym6PzAre3MX3cgSbq3h4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FnR7VLPNFrn28EDtPsoATyxxTXZCAuV3tb7SsW/9jebX2SX0v4r7J/R7fMLoJ7cpK
         Su3gimxzk0KXEGDTLnDoDAJniOz+fcXTFzb03bt+Ps8o0AOUs6ZtkyooIN5AcuLplB
         TiTwU1DMO1VEeWgLA2Xysd4fzhpqSkfUctdsSZoA=
Message-ID: <bf30363b-44f3-13da-48b1-1e7567a337ee@digikod.net>
Date:   Tue, 27 Sep 2022 18:47:53 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5] selftests/landlock: Skip overlayfs tests not supported
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        linux-kselftest@vger.kernel.org
References: <20220824015852.32257-1-jeffxu@chromium.org>
 <ccadad07-53a6-e86e-602b-1d5615a5f9e4@digikod.net>
 <CABi2SkWfTvA+40K+=LkPnGxvL_tKGbuaMog3ZC-ohmkVGgmsug@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CABi2SkWfTvA+40K+=LkPnGxvL_tKGbuaMog3ZC-ohmkVGgmsug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 26/09/2022 16:23, Jeff Xu wrote:
> On Thu, Aug 25, 2022 at 1:23 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> As discussed for the v4, the next version of this patch needs a
>> TEST_F_FORK() fix.
>>
> I can make TEST_F_FORK() to be skipped when SKIP() is called
> in FIXTURE_SETUP(), but this makes FIXTURE_TEARDOWN()
> complicated, because SKIP() can be called after any resource
> creation failure in the FIXTURE_SETUP().
> 
> Another (better) option:  add generic FIXTURE_CONFIG_CHECK()
> FIXTURE_CONFIG_CHECK() checks the runtime configuration for
> current FIXTURE, if the configuration is not met, the whole test will be
> skipped, including FIXTURE_SETUP()/TEARDOWN(), TEST_F_FORK(),
> so there is no resource clear up issue after test.

This looks like a good idea. What do you think Shuah?


> 
>> Please add a link to the previous patch (lore.kernel.org) for each new
>> version.
>>
>>
>> On 24/08/2022 03:58, jeffxu@chromium.org wrote:
>>> From: Jeff Xu <jeffxu@chromium.org>
>>>
>>> overlayfs can be disabled in the kernel configuration (which is the case
>>> for chromeOS), causing related tests to fail.  Skip such tests when an
>>> overlayfs mount operation failed because the running kernel doesn't
>>> support this file system.
>>>
>>> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>>> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>>> ---
>>>    tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++--
>>>    1 file changed, 51 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>>> index 21a2ce8fa739..645304d9fe98 100644
>>> --- a/tools/testing/selftests/landlock/fs_test.c
>>> +++ b/tools/testing/selftests/landlock/fs_test.c
>>> @@ -11,6 +11,7 @@
>>>    #include <fcntl.h>
>>>    #include <linux/landlock.h>
>>>    #include <sched.h>
>>> +#include <stdio.h>
>>>    #include <string.h>
>>>    #include <sys/capability.h>
>>>    #include <sys/mount.h>
>>> @@ -169,6 +170,42 @@ static int remove_path(const char *const path)
>>>        return err;
>>>    }
>>>
>>> +static bool fgrep(FILE *file, const char *str)
>>> +{
>>> +     char line[32];
>>> +     int str_len = strlen(str);
>>> +
>>> +     while (!feof(file)) {
>>> +             if (!fgets(line, sizeof(line), file))
>>> +                     break;
>>> +             if (strncmp(line, str, str_len))
>>> +                     continue;
>>> +
>>> +             return true;
>>> +     }
>>> +
>>> +     return false;
>>> +}
>>> +
>>> +static bool supports_overlayfs(void)
>>> +{
>>> +     bool ret;
>>> +     FILE *file = fopen("/proc/filesystems", "r");
>>> +
>>> +     /*
>>> +      * A failed attempt to open /proc/filesystems
>>> +      * implies that the file system is supported (default
>>> +      * behavior). This can help detect such unattended issue
>>> +      * (which should not happen)."
>>> +      */
>>> +     if (!file)
>>> +             return true;
>>> +
>>> +     ret = fgrep(file, "nodev\toverlay\n");
>>> +     fclose(file);
>>> +     return ret;
>>> +}
>>> +
>>>    static void prepare_layout(struct __test_metadata *const _metadata)
>>>    {
>>>        disable_caps(_metadata);
>>> @@ -3404,6 +3441,8 @@ FIXTURE(layout2_overlay) {};
>>>
>>>    FIXTURE_SETUP(layout2_overlay)
>>>    {
>>> +     int ret, err;
>>> +
>>>        prepare_layout(_metadata);
>>>
>>>        create_directory(_metadata, LOWER_BASE);
>>> @@ -3431,11 +3470,20 @@ FIXTURE_SETUP(layout2_overlay)
>>>        create_directory(_metadata, MERGE_DATA);
>>>        set_cap(_metadata, CAP_SYS_ADMIN);
>>>        set_cap(_metadata, CAP_DAC_OVERRIDE);
>>> -     ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
>>> -                        "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
>>> -                        ",workdir=" UPPER_WORK));
>>> +
>>> +     ret = mount("overlay", MERGE_DATA, "overlay", 0,
>>> +                "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
>>> +                ",workdir=" UPPER_WORK);
>>> +     err = errno;
>>>        clear_cap(_metadata, CAP_DAC_OVERRIDE);
>>>        clear_cap(_metadata, CAP_SYS_ADMIN);
>>> +
>>> +     if (ret == -1) {
>>> +             ASSERT_EQ(ENODEV, err);
>>> +             ASSERT_FALSE(supports_overlayfs());
>>> +             SKIP(return, "overlayfs is not supported");
>>> +     }
>>> +     ASSERT_EQ(0, ret);
>>>    }
>>>
>>>    FIXTURE_TEARDOWN(layout2_overlay)
>>>
>>> base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
