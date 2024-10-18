Return-Path: <linux-kselftest+bounces-20082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AD9A319A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499EF1F23780
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 00:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D428382;
	Fri, 18 Oct 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrvcxCkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D620E307;
	Fri, 18 Oct 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729210435; cv=none; b=MzNX9P4l+y9HonI4n3RbnvctctCngJX16klzyeeMKlr6F1oYGcGyzTMYwR9iGHwy/jd9W15i+78AylJd0l5bZC8NE7lmp6Hw7MdasAY8NkYuOttASDBK777mD5MgEt5TJbRijl6gbRJsczGlWRuvQSdAfzwDbS2+no6skCrjwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729210435; c=relaxed/simple;
	bh=A4ORQja7fiMU8JPsOS2T3Da+mgxyrdNj5pL0ikMGfAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q75NizkauyYR/LSVHFy+aKG5FX9VrVLq+07cca8RHvr9o3NXsGXnG3V7ijBbg+b9UX38Cgk3TxcW98Hg5zAueAexbHSGqqMLJzMC1ROxRPkNwl7Vb4YD0gRS0ZaDAKOq35R65PChMS6E/mgfvHEEbZWIWP69aziXoya0pNwFOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrvcxCkr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1100407b3a.3;
        Thu, 17 Oct 2024 17:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729210433; x=1729815233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bHnVXT36DhW84Lq7HZPsNrVtNWp2/HriPWuuTi85+c=;
        b=RrvcxCkrvXGWlSjKIVP2Q0crHXZY5b8yWiYoX6QlIbt+skMj7lWhRQz8huE31slI8R
         H+a/2j0A9wT8FV60IJLhz90kosGWPZbaMg3zKMFo1HX4rOnHgMiilnEyJh1YXeyYx8R0
         aNbv5EFoV7venO9ThrK0wvI3H+TtRMUi/JdAuj5c8nkmXM4NAq3dCHcZVB1WHRs0+5+s
         3lIO0KjXclJA/Uh31OhgoT2xZMzz6uy/sWzeL9/Bie5K9pRuU+Y1KZKD+f7n3UzKspAR
         PbtVE+ARvskqBz9GpWpmzFsv9VkhDmXUqwFa5FXCAfHNX1/fLk5PwY8Gk/ynNzdOt6i3
         zsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729210433; x=1729815233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bHnVXT36DhW84Lq7HZPsNrVtNWp2/HriPWuuTi85+c=;
        b=oAkn5mKX1TLBhpNCaInANZCT1oWbSBhUd4u+2IaV8hvgOBqnDXt9rZ7wTmijR7YHZt
         IJMOhEDEfE5sqwyYobKNU0sv5qbiZG0AZq7UPVA8R1XuBVNKK0SBYARAy6gNN4qq7LSk
         7kfbo9djLBI1iUriOSAxTpTPjnfYCzVAF/pnLRTWqDmrbkRIKXCthgq/q5eQzXnScbNE
         Q4+EzvR3xPX7SXTkGqO+mjqvjepn80B9QM4MqDfVJnoQpzgMsLrztfIp8EoTFdqKRynm
         qcgXDmJJl/ctvSkNpqSCroXD8yhDgepPo7UuQ2velsyyrGGFTlJD2vtEAwih0LQyKJpN
         ek9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIUcHUB/CVC4TeQB8CLows5wEXybLDqoRLIkz5TYDMVPrBRaf3dnkbOh63r6WAVVZstIUSQXTSj+HZKQ4=@vger.kernel.org, AJvYcCW/XhYueiMFMeUZpULZ09/9TgxurWnTCG9N3+zvVia4HHcdoEqczN4JDbsLbYC4vTjj9Y9CBSjz62nmYcvyynTW@vger.kernel.org, AJvYcCX+glslzY+Hkll81qmaC8P7Oyiu8vAihMHIr4+46khPumVZ8GU4zeXkg1y8Qet4zASHVmWfySU6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SX762NA0GQfe10QCTvEbnNEosULo5uA/Jn7z0yFDiJBK7Y42
	tC1kkLAnblJx9+OrPRtf9VfXsoGJo65DF5QeqaOKywtRR56TfZXLiwZOoE4=
X-Google-Smtp-Source: AGHT+IE4eIGAuFz5A8/XxDMQsWVTVVn6wXZSu45Z6xcPNTBrlE6qIyaFLbrUmzmoEpUW9FmUCJc8PA==
X-Received: by 2002:a05:6a00:23d1:b0:71e:6f63:f076 with SMTP id d2e1a72fcca58-71ea31927d8mr1183658b3a.5.1729210433223;
        Thu, 17 Oct 2024 17:13:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3314192sm255271b3a.41.2024.10.17.17.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 17:13:52 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:13:52 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@oracle.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Message-ID: <ZxGoQHqXTNW7C7MB@mini-arch>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
 <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>

On 10/17, Anjali Kulkarni wrote:
> Kunit tests to test hash table add, delete, duplicate add and delete.
> Add following configs and compile kernel code:
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> CONFIG_NET=y
> CONFIG_KUNIT=m
> CONFIG_CN_HASH_KUNIT_TEST=m
> 
> To run kunit tests:
> sudo modprobe cn_hash_test
> 
> Output of kunit tests and hash table contents are displayed in
> /var/log/messages (at KERN_DEBUG level).
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/cn_hash.c   |  40 ++++++++
>  drivers/connector/connector.c |  12 +++
>  include/linux/connector.h     |   4 +
>  lib/Kconfig.debug             |  17 ++++
>  lib/Makefile                  |   1 +
>  lib/cn_hash_test.c            | 167 ++++++++++++++++++++++++++++++++++
>  lib/cn_hash_test.h            |  10 ++
>  7 files changed, 251 insertions(+)
>  create mode 100644 lib/cn_hash_test.c
>  create mode 100644 lib/cn_hash_test.h
> 
> diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
> index a079e9bcea6d..40099b5908ac 100644
> --- a/drivers/connector/cn_hash.c
> +++ b/drivers/connector/cn_hash.c
> @@ -170,6 +170,46 @@ int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
>  	return -EINVAL;
>  }
>  
> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> +				int *hkey, int *key_display)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	int key, count = 0;
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	key = hash_min(pid, HASH_BITS(hdev->uexit_pid_htable));
> +	pr_debug("Bucket: %d\n", key);
> +
> +	hlist_for_each_entry(hnode,
> +			&hdev->uexit_pid_htable[key],
> +			uexit_pid_hlist) {
> +		if (key_display[key] != 1) {
> +			if (hnode->uexit_pid_hlist.next == NULL)
> +				pr_debug("pid %d ", hnode->pid);
> +			else
> +				pr_debug("pid %d --> ", hnode->pid);
> +		}
> +		count++;
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +
> +	if ((key_display[key] != 1) && !count)
> +		pr_debug("(empty)\n");
> +
> +	pr_debug("\n");
> +
> +	*hkey = key;
> +
> +	if (count > max_len) {
> +		pr_err("%d entries in hlist for key %d, expected %d\n",
> +				count, key, max_len);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  bool cn_hash_table_empty(struct cn_hash_dev *hdev)
>  {
>  	bool is_empty;
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index c1c0dcec53c0..2be2fe1adc12 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -304,6 +304,18 @@ int cn_get_exval(pid_t pid)
>  }
>  EXPORT_SYMBOL_GPL(cn_get_exval);
>  
> +int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display)
> +{
> +	struct cn_dev *dev = &cdev;
> +
> +	if (!cn_already_initialized)
> +		return 0;
> +
> +	return cn_hash_display_hlist(dev->hdev, pid, max_len,
> +					hkey, key_display);
> +}
> +EXPORT_SYMBOL_GPL(cn_display_hlist);
> +
>  bool cn_table_empty(void)
>  {
>  	struct cn_dev *dev = &cdev;
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index 5384e4bb98e8..a75c3fcf182a 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -168,4 +168,8 @@ int cn_get_exval(pid_t pid);
>  bool cn_table_empty(void);
>  bool cn_hash_table_empty(struct cn_hash_dev *hdev);
>  
> +int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display);
> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> +				int *hkey, int *key_display);
> +
>  #endif				/* __CONNECTOR_H */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7315f643817a..290cf0a6befa 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2705,6 +2705,23 @@ config HASHTABLE_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config CN_HASH_KUNIT_TEST
> +	tristate "KUnit Test for connector hashtable code" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the hashtable KUnit test suite.
> +	  It tests the basic functionality of the API defined in
> +	  drivers/connector/cn_hash.c.
> +	  CONFIG_CONNECTOR=y, CONFIG_PROC_EVENTS=y and CONFIG_NET=y needs
> +	  to be enabled along with CONFIG_CN_HASH_KUNIT_TEST=m and
> +	  CONFIG_KUNIT=m in .config file to compile and then test as a kernel
> +	  module with "modprobe cn_hash_test".
> +	  For more information on KUnit and unit tests in general please
> +	  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +

Looks like this needs to depend on CONFIG_CONNECTOR? Otherwise, the
existing kunit tester complains about the missing symbols (see below).
Please also hold off reposting for a couple of days to give people some
time to review.

ERROR:root:ld: vmlinux.o: in function `cn_hash_test_dup_del':
cn_hash_test.c:(.text+0x3e9dc3): undefined reference to `cn_del_get_exval'
ld: cn_hash_test.c:(.text+0x3e9dee): undefined reference to `cn_del_get_exval'
ld: cn_hash_test.c:(.text+0x3e9e22): undefined reference to `cn_table_empty'
ld: vmlinux.o: in function `cn_display_htable':
cn_hash_test.c:(.text+0x3e9f67): undefined reference to `cn_display_hlist'
ld: vmlinux.o: in function `cn_hash_test_del_get_exval':
cn_hash_test.c:(.text+0x3ea037): undefined reference to `cn_del_get_exval'
ld: cn_hash_test.c:(.text+0x3ea088): undefined reference to `cn_table_empty'
ld: vmlinux.o: in function `cn_hash_test_dup_add':
cn_hash_test.c:(.text+0x3ea176): undefined reference to `cn_add_elem'
ld: cn_hash_test.c:(.text+0x3ea19e): undefined reference to `cn_get_exval'
ld: cn_hash_test.c:(.text+0x3ea1dc): undefined reference to `cn_add_elem'
ld: cn_hash_test.c:(.text+0x3ea205): undefined reference to `cn_get_exval'
ld: vmlinux.o: in function `cn_hash_test_del':
cn_hash_test.c:(.text+0x3ea387): undefined reference to `cn_del_get_exval'
ld: cn_hash_test.c:(.text+0x3ea3ab): undefined reference to `cn_get_exval'
ld: cn_hash_test.c:(.text+0x3ea3fd): undefined reference to `cn_table_empty'
ld: vmlinux.o: in function `cn_hash_test_add':
cn_hash_test.c:(.text+0x3ea571): undefined reference to `cn_add_elem'
ld: cn_hash_test.c:(.text+0x3ea591): undefined reference to `cn_get_exval'
make[3]: *** [../scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[2]: *** [/home/kunit/testing/Makefile:1166: vmlinux] Error 2
make[1]: *** [/home/kunit/testing/Makefile:224: __sub-make] Error 2
make: *** [Makefile:224: __sub-make] Error 2

---
pw-bot: cr

