Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7562C5A35AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiH0Hpc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH0Hpb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 03:45:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CAE766E;
        Sat, 27 Aug 2022 00:45:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f24so705549plr.1;
        Sat, 27 Aug 2022 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MW9XiDm5TEyHTMt64geez1Y9EaOyTSWqr/veHEG1pHc=;
        b=mMytdrhGcNtVe4F+FPJ9h2qtSgm7tV8neZRZp6lQ+Z8nnBKXe98u0mhTCiPlRbcf5e
         /1KnomukCs/u1WC+ABAupLGqlDEmDK1SS50VMs3QXiQGyiFhyD37Pe8X3+nPNWOdGwbe
         Q8caIRb5jCyig2tdoQ4ZFC9/rBOBy2pyVTL232xc5mYcy+VdH/gzG9QN1MPuY6iB4hKk
         uHLyxtHD1APTDStoLT7E7RRXgs1owHveJ/YjdCupOZgGK2ptBB+pFD4dQBsMb15uvPV1
         7REeP8EYtRzTwJ1hFDkfTdofCPYtS1VwpGuGM0oytY3qfDl6YJLcORo1fx6b4wAcZrQS
         41pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MW9XiDm5TEyHTMt64geez1Y9EaOyTSWqr/veHEG1pHc=;
        b=eqRiIZNODHDkgXsejs1TrfCHli75iPSlTAkaD9Wz4nCFhXvXpk3bk9ICZwBZnqHlt3
         qv2I1q/GZbk1KawwjC+j0RPmRerWT1mfZpnWV3SOUZWaOVRLTHoyCztHGoOIgIVIZBMc
         iN7mHQk4wevLZ3ACZCdp+Uz2M2/9k9Lv8Zwf1FxdCWZzvYvmWmqd2RFzPZNX6k/E6yYx
         FdQdpE2muzPSYtSIswG4s7x7tFjoBtoZ5RPROBMsC2axQPfPBi0mhgTwuUqtYZ84uIPy
         nyBXyGLK+48W3HT0fhYSNkUSIf/kYn9XJmCW51NIU7YuImCO7R1t5dJh5XWTO/TeqwwE
         lpig==
X-Gm-Message-State: ACgBeo3Ktgn+Cf2AuWHftUDqWZAhNl94yHh0j2YAz7PVbJD5mZSnNrTP
        6jEpN3OlQLE6Klhz161/APE=
X-Google-Smtp-Source: AA6agR6pWBF3LlPGmIDMdGX5wvr1eaXH0qxppIqaWpGF9U1YXO1vUH1JDjoO0TswSaQZWWhXRfNlwg==
X-Received: by 2002:a17:90a:c789:b0:1fa:6bc0:77f6 with SMTP id gn9-20020a17090ac78900b001fa6bc077f6mr8447416pjb.1.1661586328877;
        Sat, 27 Aug 2022 00:45:28 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b00172de80fec4sm2884558pll.69.2022.08.27.00.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 00:45:28 -0700 (PDT)
Message-ID: <a1ec9c94-e69b-78c0-ea0f-31cceee8452a@gmail.com>
Date:   Sat, 27 Aug 2022 14:45:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v11 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/22 22:06, Kuppuswamy Sathyanarayanan wrote:
> Attestation is used to verify the TDX guest trustworthiness to other
> entities before provisioning secrets to the guest. For example, a key
> server may request for attestation before releasing the encryption keys
> to mount the encrypted rootfs or secondary drive.
> 
> During the TDX guest launch, the initial contents (including the
> firmware image) and configuration of the guest are recorded by the
> Intel TDX module in build time measurement register (MRTD). After TDX
> guest is created, run-time measurement registers (RTMRs) can be used by
> the guest software to extend the measurements. TDX supports 4 RTMR
> registers, and TDG.MR.RTMR.EXTEND TDCALL is used to update the RTMR
> registers securely. RTMRs are mainly used to record measurements
> related to sections like the kernel image, command line parameters,
> initrd, ACPI tables, firmware data, configuration firmware volume (CFV)
> of TDVF, etc. For complete details, please refer to TDX Virtual
> Firmware design specification, sec titled "TD Measurement".
> 
> At TDX guest runtime, the Intel TDX module reuses the Intel SGX
> attestation infrastructure to provide support for attesting to these
> measurements as described below.
> 
> The attestation process consists of two steps: TDREPORT generation and
> Quote generation.
> 
> TDREPORT (TDREPORT_STRUCT) is a fixed-size data structure generated by
> the TDX module which contains guest-specific information (such as build
> and boot measurements), platform security version, and the MAC to
> protect the integrity of the TDREPORT. The guest kernel uses
> TDCALL[TDG.MR.REPORT] to get the TDREPORT from the TDX module. A
> user-provided 64-Byte REPORTDATA is used as input and included in the
> TDREPORT. Typically it can be some nonce provided by attestation
> service so the TDREPORT can be verified uniquely. More details about
> the TDREPORT can be found in Intel TDX Module specification, section
> titled "TDG.MR.REPORT Leaf".
> 
> TDREPORT by design can only be verified on the local platform as the
> MAC key is bound to the platform. To support remote verification of
> the TDREPORT, TDX leverages Intel SGX Quote Enclave (QE) to verify
> the TDREPORT locally and convert it to a remote verifiable Quote.
> 
> After getting the TDREPORT, the second step of the attestation process
> is to send it to the QE to generate the Quote. TDX doesn't support SGX
> inside the guest, so the QE can be deployed in the host, or in another
> legacy VM with SGX support. QE checks the integrity of TDREPORT and if
> it is valid, a certified quote signing key is used to sign the Quote.
> How to send the TDREPORT to QE and receive the Quote is implementation
> and deployment specific.
> 
> Implement a basic guest misc driver to allow userspace to get the
> TDREPORT. After getting TDREPORT, the userspace attestation software
> can choose whatever communication channel available (i.e. vsock or
> hypercall) to send the TDREPORT to QE and receive the Quote.
> 
> Also note that explicit access permissions are not enforced in this
> driver because the quote and measurements are not a secret. However
> the access permissions of the device node can be used to set any
> desired access policy. The udev default is usually root access
> only.
> 
> Operations like getting TDREPORT or Quote generation involves sending
> a blob of data as input and getting another blob of data as output. It
> was considered to use a sysfs interface for this, but it doesn't fit
> well into the standard sysfs model for configuring values. It would be
> possible to do read/write on files, but it would need multiple file
> descriptors, which would be somewhat messy. IOCTLs seems to be the best
> fitting and simplest model for this use case. This is similar to AMD
> SEV platform, which also uses IOCTL interface to support attestation.
> 
> Any distribution enabling TDX is also expected to need attestation. So
> enable it by default with TDX guest support.
> 

On what tree this patch series is based on?

And as this series is multi-patch, it's customary to have cover letter
(or [PATCH 0/?]).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
