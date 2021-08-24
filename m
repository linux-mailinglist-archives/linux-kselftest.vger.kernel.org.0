Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37CA3F60A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhHXOkn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbhHXOkm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 10:40:42 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4968BC061764
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:39:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s16so20714946ilo.9
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wrmj9NxeK50Yh0KWY83ZwhjXt9JLXGrzQPU3KpybYTE=;
        b=Crgu+M678i9zBflxzx+Djt10g4XfQusYeZq42NCA09ryj+wzzNIGUtZVvIwhOBDH5j
         3FFq0e+QBD3pAGr6uldd0cqnv0O9vnkqjb6jEFAd6VME2YpiEsw6bbtEeed5TGwC+0FZ
         JjboGrYQx7ZJcMe6uqM/OC56i68t93XoSmfLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wrmj9NxeK50Yh0KWY83ZwhjXt9JLXGrzQPU3KpybYTE=;
        b=MsZScXaq8g7KsEhNoyo8hWS2kBPOxNAciX1gEzw6KRLr62nH7LBNhGSfasm/9RVouy
         9hJb1KnMrimIfQRuv2ue2kwq8+LHzEONQH/4H1k0ibgPBVWRXp1HUrIx4N0IcljERcG4
         NIcHss/PhY9LzRkC75HMWZFNTaTD0H6uYt28MzEvY7bVf8lIiLrUh1QENUWTmTK68x9W
         6Ty19LFRmuOWD+ayxoNT6r/QZrIwbSnoGoyjbN9vdQvDPuxFk2QRzkLhYSVlVXvS7jaH
         yCywJbTBABJqFjGMXEJh3CmEuHWTBNbDfjJdSUobGScfL/AHUHAoWk4HUckwFRN/h0Hl
         t5Tg==
X-Gm-Message-State: AOAM531uVPhw5vQoOy9H7dXKqP/GaM32OX06JbTAjCdmGHlChNeY3u19
        9GZhFXkZ+k7H/+LUOK76hYTmWg==
X-Google-Smtp-Source: ABdhPJxpg3d08Q6y9K5HtvozlC1WOSSmlKy7Dbn0wEh5M2V8pYpnHyzPepHLOdDKueehZ9sDrGW4Lg==
X-Received: by 2002:a92:3f0b:: with SMTP id m11mr27908064ila.265.1629815997687;
        Tue, 24 Aug 2021 07:39:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p12sm9916627ilp.87.2021.08.24.07.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:39:57 -0700 (PDT)
Subject: Re: [PATCH linux-next] tools: remove unneeded semicolon
To:     cgel.zte@gmail.com, jasowang@redhat.com
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org, mst@redhat.com, zhang.yunkai@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210802071449.588393-1-zhang.yunkai@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e501f3f4-2eb7-a742-57ac-34f4f8e83d82@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:39:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210802071449.588393-1-zhang.yunkai@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/2/21 1:14 AM, cgel.zte@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> Fix the following coccicheck REVIEW:
> ./tools/testing/selftests/timers/inconsistency-check.c:75:2-3 REVIEW
> Unneeded semicolon
> ./tools/testing/selftests/timers/set-timer-lat.c:83:2-3 REVIEW Unneeded
> semicolon
> ./tools/virtio/virtio-trace/trace-agent-ctl.c:78:2-3 REVIEW Unneeded
> semicolon
> ./tools/testing/selftests/timers/nanosleep.c:75:2-3 REVIEW Unneeded
> semicolon
> ./tools/testing/selftests/timers/nsleep-lat.c:75:2-3 REVIEW Unneeded
> semicolon
> ./tools/testing/selftests/timers/alarmtimer-suspend.c:82:2-3 REVIEW
> Unneeded semicolon
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>   tools/testing/selftests/timers/alarmtimer-suspend.c  | 2 +-
>   tools/testing/selftests/timers/inconsistency-check.c | 2 +-
>   tools/testing/selftests/timers/nanosleep.c           | 2 +-
>   tools/testing/selftests/timers/nsleep-lat.c          | 2 +-
>   tools/testing/selftests/timers/set-timer-lat.c       | 2 +-
>   tools/virtio/virtio-trace/trace-agent-ctl.c          | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
> index 4da09dbf83ba..54da4b088f4c 100644
> --- a/tools/testing/selftests/timers/alarmtimer-suspend.c
> +++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
> @@ -79,7 +79,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   
> diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
> index 022d3ffe3fbf..e6756d9c60a7 100644
> --- a/tools/testing/selftests/timers/inconsistency-check.c
> +++ b/tools/testing/selftests/timers/inconsistency-check.c
> @@ -72,7 +72,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   
> diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
> index 71b5441c2fd9..433a09676aeb 100644
> --- a/tools/testing/selftests/timers/nanosleep.c
> +++ b/tools/testing/selftests/timers/nanosleep.c
> @@ -72,7 +72,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   
> diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
> index eb3e79ed7b4a..a7ca9825e106 100644
> --- a/tools/testing/selftests/timers/nsleep-lat.c
> +++ b/tools/testing/selftests/timers/nsleep-lat.c
> @@ -72,7 +72,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   
> diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
> index 50da45437daa..d60bbcad487f 100644
> --- a/tools/testing/selftests/timers/set-timer-lat.c
> +++ b/tools/testing/selftests/timers/set-timer-lat.c
> @@ -80,7 +80,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   
> diff --git a/tools/virtio/virtio-trace/trace-agent-ctl.c b/tools/virtio/virtio-trace/trace-agent-ctl.c
> index 73d253d4b559..39860be6e2d8 100644
> --- a/tools/virtio/virtio-trace/trace-agent-ctl.c
> +++ b/tools/virtio/virtio-trace/trace-agent-ctl.c
> @@ -75,7 +75,7 @@ static int wait_order(int ctl_fd)
>   
>   		if (ret)
>   			break;
> -	};
> +	}
>   
>   	return ret;
>   
> 

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
