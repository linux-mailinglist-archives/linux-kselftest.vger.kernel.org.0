Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7D6D867A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjDETDf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 15:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDETDe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 15:03:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF39132
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 12:03:32 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-324419ed7d9so156235ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680721412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TVi1lyJMmYcYaP9PAZ762NsVh9YbaxOBrDxQLPvKzw=;
        b=DJqRYyvrDqGNM8BA/RjvPC+5g6rJMIho1xJqOjAqClM+Pvbqicldec1Urlh+Ny1j6v
         GUDgHy7enhtHiy+x02OSEMJa9/+EEueHNNPkwsbq+mrwBdsdGc9NlwNSP3q8R0fpI9+X
         N0VFkMExIbxVmgHd01B7NJFp5G3Ph+RKBqQ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TVi1lyJMmYcYaP9PAZ762NsVh9YbaxOBrDxQLPvKzw=;
        b=gk+FuzHY+u8U6eYdl9OEzYAilPuR0MgRK6uDj0F3vARzJoWOzAy/PRgp5Vrcxvv8MG
         0tYo+KkJeGZNR4Ht98k9cpWStuGRRBGiOVMQN2HafkPM+S1cxtbRJ8lO3djHIAzG4qGC
         Tbnph5+34cPMisR2f3ndKcCsm++QkaBwq2KleUuW2c1vD6PJYrdJAwfV5Pev2HEbu84E
         XV1/D5GEJq3WM4e55O5MAKQPLSX2ymfImIiW56hxsxRJpPEgasQY3f514sp4PrcyDwkI
         Ovoye2QFFAse2RQ+AfM1K4DixVgpd4IjriqpAgpJbcW0devWNcuvH4W8VoB1Dd0PT70C
         Se5A==
X-Gm-Message-State: AAQBX9e2Pv7FnqaJWpAKEirj1lDdNXASPRPEeTsPSU7TPu91NHcARgjy
        cyD1J+lWebIBZ0pcTIEYyOOE8g==
X-Google-Smtp-Source: AKy350bGyW3saNrk3z4H+2SnOMjOBKRW77KKmO2Uq+eRtkg8yKQT0zqEraoujyGm/ZRmY9HClVVqpg==
X-Received: by 2002:a05:6e02:2218:b0:327:fb76:84e5 with SMTP id j24-20020a056e02221800b00327fb7684e5mr749178ilf.0.1680721412110;
        Wed, 05 Apr 2023 12:03:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b1-20020a92a041000000b00326bd11f5d1sm971992ilm.11.2023.04.05.12.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 12:03:31 -0700 (PDT)
Message-ID: <8038b636-7275-4f44-0b1f-df4190b94a40@linuxfoundation.org>
Date:   Wed, 5 Apr 2023 13:03:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] selftests: media_tests: Add new subtest to
 video_device_test
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230401092207.16667-1-ivan.orlov0322@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230401092207.16667-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/1/23 03:22, Ivan Orlov wrote:
> Add new subtest to video_device_test to cover the VIDIOC_G_PRIORITY
> and VIDIOC_S_PRIORITY ioctl calls. This test tries to set the priority
> associated with the file descriptior via ioctl VIDIOC_S_PRIORITY
> command from V4L2 API. After that, the test tries to get the new
> priority via VIDIOC_G_PRIORITY ioctl command and compares the result
> with the v4l2_priority it set before. At the end, the test restores the
> old priority.
> 
> This test will increase the code coverage for video_device_test, so
> I think it might be useful. Additionally, this patch will refactor the
> video_device_test a little bit, according to the new functionality.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>   .../selftests/media_tests/video_device_test.c | 131 +++++++++++++-----
>   1 file changed, 93 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/media_tests/video_device_test.c b/tools/testing/selftests/media_tests/video_device_test.c
> index 0f6aef2e2593..5e6f65ad2ca3 100644
> --- a/tools/testing/selftests/media_tests/video_device_test.c
> +++ b/tools/testing/selftests/media_tests/video_device_test.c
> @@ -13,18 +13,9 @@
>    * in the Kselftest run. This test should be run when hardware and driver
>    * that makes use of V4L2 API is present.
>    *
> - * This test opens user specified Video Device and calls video ioctls in a
> - * loop once every 10 seconds.
> - *
>    * Usage:
>    *	sudo ./video_device_test -d /dev/videoX
> - *
> - *	While test is running, remove the device or unbind the driver and
> - *	ensure there are no use after free errors and other Oops in the
> - *	dmesg.
> - *	When possible, enable KaSan kernel config option for use-after-free
> - *	error detection.
> -*/
> + */

Leave this text here so it is easy to spot. There is no need to move this
down.

>   
>   #include <stdio.h>
>   #include <unistd.h>
> @@ -37,45 +28,67 @@
>   #include <time.h>
>   #include <linux/videodev2.h>
>   
> -int main(int argc, char **argv)
> +#define PRIORITY_MAX 4
> +
> +int priority_test(int fd)
>   {
> -	int opt;
> -	char video_dev[256];
> -	int count;
> -	struct v4l2_tuner vtuner;
> -	struct v4l2_capability vcap;
> +	/* This test will try to update the priority associated with a file descriptor */
> +
> +	enum v4l2_priority old_priority, new_priority, priority_to_compare;
>   	int ret;
> -	int fd;
> +	int result = 0;
>   
> -	if (argc < 2) {
> -		printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
> -		exit(-1);
> +	ret = ioctl(fd, VIDIOC_G_PRIORITY, &old_priority);
> +	if (ret < 0) {
> +		printf("Failed to get priority: %s\n", strerror(errno));
> +		return -1;
> +	}
> +	new_priority = (old_priority + 1) % PRIORITY_MAX;
> +	ret = ioctl(fd, VIDIOC_S_PRIORITY, &new_priority);
> +	if (ret < 0) {
> +		printf("Failed to set priority: %s\n", strerror(errno));
> +		return -1;
> +	}
> +	ret = ioctl(fd, VIDIOC_G_PRIORITY, &priority_to_compare);
> +	if (ret < 0) {
> +		printf("Failed to get new priority: %s\n", strerror(errno));
> +		result = -1;
> +		goto cleanup;
> +	}
> +	if (priority_to_compare != new_priority) {
> +		printf("Priority wasn't set - test failed\n");
> +		result = -1;
>   	}
>   
> -	/* Process arguments */
> -	while ((opt = getopt(argc, argv, "d:")) != -1) {
> -		switch (opt) {
> -		case 'd':
> -			strncpy(video_dev, optarg, sizeof(video_dev) - 1);
> -			video_dev[sizeof(video_dev)-1] = '\0';
> -			break;
> -		default:
> -			printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
> -			exit(-1);
> -		}
> +cleanup:
> +	ret = ioctl(fd, VIDIOC_S_PRIORITY, &old_priority);
> +	if (ret < 0) {
> +		printf("Failed to restore priority: %s\n", strerror(errno));
> +		return -1;
>   	}
> +	return result;
> +}
> +
> +int loop_test(int fd)
> +{
> +	/*
> +	 * This test opens user specified Video Device and calls video ioctls in a
> +	 * loop once every 10 seconds.
> +	 * While test is running, remove the device or unbind the driver and
> +	 * ensure there are no use after free errors and other Oops in the
> +	 * dmesg.
> +	 * When possible, enable KaSan kernel config option for use-after-free
> +	 * error detection.
> +	 */
> +	int count;
> +	struct v4l2_tuner vtuner;
> +	struct v4l2_capability vcap;
> +	int ret;
>   
>   	/* Generate random number of interations */
>   	srand((unsigned int) time(NULL));
>   	count = rand();
>   
> -	/* Open Video device and keep it open */
> -	fd = open(video_dev, O_RDWR);
> -	if (fd == -1) {
> -		printf("Video Device open errno %s\n", strerror(errno));
> -		exit(-1);
> -	}
> -
>   	printf("\nNote:\n"
>   	       "While test is running, remove the device or unbind\n"
>   	       "driver and ensure there are no use after free errors\n"
> @@ -98,4 +111,46 @@ int main(int argc, char **argv)
>   		sleep(10);
>   		count--;
>   	}
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt;
> +	char video_dev[256];
> +	int fd;
> +	int test_result;
> +
> +	if (argc < 2) {
> +		printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
> +		exit(-1);
> +	}
> +
> +	/* Process arguments */
> +	while ((opt = getopt(argc, argv, "d:")) != -1) {
> +		switch (opt) {
> +		case 'd':
> +			strncpy(video_dev, optarg, sizeof(video_dev) - 1);
> +			video_dev[sizeof(video_dev)-1] = '\0';
> +			break;
> +		default:
> +			printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
> +			exit(-1);
> +		}
> +	}
> +
> +	/* Open Video device and keep it open */
> +	fd = open(video_dev, O_RDWR);
> +	if (fd == -1) {
> +		printf("Video Device open errno %s\n", strerror(errno));
> +		exit(-1);
> +	}
> +
> +	test_result = priority_test(fd);
> +	if (!test_result)
> +		printf("Priority test - PASSED\n");
> +	else
> +		printf("Priority test - FAILED\n");
> +
> +	loop_test(fd);
>   }

Otherwise looks good to me.

thanks,
-- Shuah
