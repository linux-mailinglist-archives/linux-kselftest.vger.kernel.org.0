Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0655CBDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiF0GxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiF0GxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 02:53:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215EC26D3;
        Sun, 26 Jun 2022 23:53:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s1so11545475wra.9;
        Sun, 26 Jun 2022 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9HAkbZXww63s+0bv/ZmVBk4h2mlRk2b5X7UwuMp2450=;
        b=ESN+8Do1SE3GUTvKJFRN4wmhzGOeAsxKSVSeauBw7GkWvNrHtgijUHi7k0Wx873fCM
         cNvb2edqtxX1AlQgDByvyORqsmVvKvMlsr5YsNWnBRVrJar6/oslGxhw0l14nWdMW3II
         DCz1nT6WTg29zu1yV9CgLGeC58hEznbG7Vqz9cMmvUIXzdHdEpGAAnatd4HhK1cYMD1E
         +OfaB1UBfsqV7zJ5oeVLME1kHMzYgyd3LcmZeGg3fgahaWV6Yg1s/yFzm61K+2sjmsCf
         jaCXNPOongdq53I7TWtX6pVEHT+VPu8dqNj6BPCnfQCcY52cNTGxO9TopZ/XTVDgj3Mo
         pLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9HAkbZXww63s+0bv/ZmVBk4h2mlRk2b5X7UwuMp2450=;
        b=vimkl1rHtaGjqhh3b3Dxi1vuBR4SfD3z5Xzyrl4kmEux3UZ7CqC45JCcDCsB7Cnnii
         QkKxpPRcMUWfghsa6cBb3pvBFWLub2FiHqwG8Gd/Yma1lxu0qEQCnNe7QK2NuHK8qvXG
         4Na9f4mK1dB/0S0tklhr1qu9X/j7o8Ctd0P1kP+LgDqvij9Mn5W3VY+UhHuG+GIDkmsp
         WwG1C4I2OTzDlgeoKp6VVtnbyAyQNPthpdC3ZH7WhHceCRqofJHyuKRZZjRoEbFtmoRY
         5PJqKZctVndBRBDDKVmOVT6ImHauf4M/mkBH8W5z+ZSSyjJG3ODkrJSHC++mWiMOxFUc
         LNjw==
X-Gm-Message-State: AJIora9KSZ0NGxT+O2wDNzNyMrb+s/iqyPCMdDHdRCPGWPMawjtf8mEB
        3h7gb4k0hEVn3orSG9H6HZmVKlfFyvPtxA==
X-Google-Smtp-Source: AGRyM1sig4gnVK31ID+ksDquPo3/G88OrQRa0WIdHga+Gi9ty3fvsFAyidLKJjgY+H2AF7Gpnenbpw==
X-Received: by 2002:a5d:6da3:0:b0:21b:ab1a:5c79 with SMTP id u3-20020a5d6da3000000b0021bab1a5c79mr10965445wrs.160.1656312787482;
        Sun, 26 Jun 2022 23:53:07 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b0039ee391a024sm17996474wmg.14.2022.06.26.23.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 23:53:07 -0700 (PDT)
Date:   Mon, 27 Jun 2022 08:53:04 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: tool: Enable virtio/PCI by default on UML
Message-ID: <20220627065304.GA43016@elementary>
References: <20220624084400.1454579-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624084400.1454579-1-davidgow@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 24, 2022 at 04:43:59PM +0800, David Gow wrote:
> There are several tests which depend on PCI, and hence need a bunch of
> extra options to run under UML. This makes it awkward to give
> configuration instructions (whether in documentation, or as part of a
> .kunitconfig file), as two separate, incompatible sets of config options
> are required for UML and "most other architectures".
> 
> For non-UML architectures, it's possible to add default kconfig options
> via the qemu_config python files, but there's no equivalent for UML. Add
> a new tools/testing/kunit/configs/arch_uml.config file containing extra
> kconfig options to use on UML.
> 
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: José Expósito <jose.exposito89@gmail.com>

After applying this patch and its dependencies, I can confirm that it is
possible to run the DRM tests with the following command:

$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests

Added a TODO for myself to remove the extra flag from the DRM docs once
this patch is merged.

Thanks a lot for making it easier!

Jose

> ---
> 
> NOTE: This has dependencies on the 'make --kunitconfig repeatable'
> series:
> https://lore.kernel.org/linux-kselftest/20220624001247.3255978-1-dlatypov@google.com/
> which, in turn, depends on:
> https://lore.kernel.org/linux-kselftest/20220520224200.3764027-1-dlatypov@google.com/
> Please apply those first.
> 
> Changes since RFC:
> https://lore.kernel.org/linux-kselftest/20220622035326.759935-1-davidgow@google.com/
> - Rebase on top of the previous kconfig patches.
> - Fix a missing make_arch_qemuconfig->make_arch_config rename (Thanks
>   Brendan)
> - Fix the tests to use the base LinuxSourceTreeOperations class, which
>   has no default kconfig options (and so won't conflict with those set
>   in the tests). Only test_build_reconfig_existing_config actually
>   failed, but I updated a few more in case the defaults changed.
> 
> 
> ---
>  tools/testing/kunit/configs/arch_uml.config |  5 +++++
>  tools/testing/kunit/kunit_kernel.py         | 14 ++++++++++----
>  tools/testing/kunit/kunit_tool_test.py      | 12 ++++++++++++
>  3 files changed, 27 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/kunit/configs/arch_uml.config
> 
> diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
> new file mode 100644
> index 000000000000..e824ce43b05a
> --- /dev/null
> +++ b/tools/testing/kunit/configs/arch_uml.config
> @@ -0,0 +1,5 @@
> +# Config options which are added to UML builds by default
> +
> +# Enable virtio/pci, as a lot of tests require it.
> +CONFIG_VIRTIO_UML=y
> +CONFIG_UML_PCI_OVER_VIRTIO=y
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index fc415ff7530e..127598fb994b 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -26,6 +26,7 @@ KUNITCONFIG_PATH = '.kunitconfig'
>  OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
>  DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
>  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> +UML_KCONFIG_PATH = 'tools/testing/kunit/configs/arch_uml.config'
>  OUTFILE_PATH = 'test.log'
>  ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
>  QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
> @@ -53,7 +54,7 @@ class LinuxSourceTreeOperations:
>  		except subprocess.CalledProcessError as e:
>  			raise ConfigError(e.output.decode())
>  
> -	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> +	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>  		return base_kunitconfig
>  
>  	def make_allyesconfig(self, build_dir: str, make_options) -> None:
> @@ -109,7 +110,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>  		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
>  		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
>  
> -	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> +	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>  		kconfig = kunit_config.parse_from_string(self._kconfig)
>  		kconfig.merge_in_entries(base_kunitconfig)
>  		return kconfig
> @@ -138,6 +139,11 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>  	def __init__(self, cross_compile=None):
>  		super().__init__(linux_arch='um', cross_compile=cross_compile)
>  
> +	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> +		kconfig = kunit_config.parse_file(UML_KCONFIG_PATH)
> +		kconfig.merge_in_entries(base_kunitconfig)
> +		return kconfig
> +
>  	def make_allyesconfig(self, build_dir: str, make_options) -> None:
>  		kunit_parser.print_with_timestamp(
>  			'Enabling all CONFIGs for UML...')
> @@ -297,7 +303,7 @@ class LinuxSourceTree:
>  		if build_dir and not os.path.exists(build_dir):
>  			os.mkdir(build_dir)
>  		try:
> -			self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
> +			self._kconfig = self._ops.make_arch_config(self._kconfig)
>  			self._kconfig.write_to_file(kconfig_path)
>  			self._ops.make_olddefconfig(build_dir, make_options)
>  		except ConfigError as e:
> @@ -328,7 +334,7 @@ class LinuxSourceTree:
>  			return self.build_config(build_dir, make_options)
>  
>  		existing_kconfig = kunit_config.parse_file(kconfig_path)
> -		self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
> +		self._kconfig = self._ops.make_arch_config(self._kconfig)
>  
>  		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
>  			return True
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index e21ae1331350..08cb2dc8ef7d 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -430,6 +430,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>  				f.write('CONFIG_KUNIT=y')
>  
>  			tree = kunit_kernel.LinuxSourceTree(build_dir)
> +			# Stub out the source tree operations, so we don't have
> +			# the defaults for any given architecture get in the
> +			# way.
> +			tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
>  			mock_build_config = mock.patch.object(tree, 'build_config').start()
>  
>  			# Should generate the .config
> @@ -447,6 +451,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>  				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
>  
>  			tree = kunit_kernel.LinuxSourceTree(build_dir)
> +			# Stub out the source tree operations, so we don't have
> +			# the defaults for any given architecture get in the
> +			# way.
> +			tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
>  			mock_build_config = mock.patch.object(tree, 'build_config').start()
>  
>  			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
> @@ -463,6 +471,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>  				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
>  
>  			tree = kunit_kernel.LinuxSourceTree(build_dir)
> +			# Stub out the source tree operations, so we don't have
> +			# the defaults for any given architecture get in the
> +			# way.
> +			tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
>  			mock_build_config = mock.patch.object(tree, 'build_config').start()
>  
>  			# ... so we should trigger a call to build_config()
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
